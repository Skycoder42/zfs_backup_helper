import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:riverpod/riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../models/config.dart';
import '../models/dataset.dart';
import '../models/managed_snapshot.dart';

final storageAdapterProvider = Provider.family(
  (ref, Config config) => StorageAdapter(config),
);

class StorageAdapter {
  final Config _config;
  final _logger = Logger('$StorageAdapter');

  StorageAdapter(this._config);

  Stream<ManagedSnapshot> listSnapshots(Dataset dataset) async* {
    final datasetDirectory = _datasetDirectory(dataset);
    _logger.fine('Found directory for dataset "$dataset": $datasetDirectory');
    if (!await datasetDirectory.exists()) {
      return;
    }

    yield* datasetDirectory
        .list()
        .whereType<File>()
        .where((file) => path.extension(file.path) == '.backup')
        .map((file) => path.basenameWithoutExtension(file.path))
        .map(ManagedSnapshot.parse);
  }

  Future<void> storeSnapshot(
    Dataset dataset,
    ManagedSnapshot snapshot,
    Stream<List<int>> zfsDataStream,
  ) async {
    final datasetDirectory = _datasetDirectory(dataset);
    await datasetDirectory.create(recursive: true);

    final snapshotFile = File.fromUri(
      datasetDirectory.uri.resolve('$snapshot.backup'),
    );
    _logger.fine('Storing snapshot "$snapshot" as $snapshotFile');
    final snapshotFileSink = snapshotFile.openWrite();
    await zfsDataStream.pipe(snapshotFileSink);
    _logger.fine('Successfully stored snapshot "$snapshot"');
  }

  Directory _datasetDirectory(Dataset dataset) => Directory.fromUri(
        _config.backupDir.uri.resolve(path.join(_config.host, dataset.name)),
      );
}
