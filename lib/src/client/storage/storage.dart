import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:riverpod/riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../models/config.dart';
import '../models/dataset.dart';
import '../models/managed_snapshot.dart';

final storageProvider = Provider.family(
  (ref, Config config) => Storage(config),
);

class Storage {
  final Config _config;

  Storage(this._config);

  Stream<ManagedSnapshot> listSnapshots(Dataset dataset) async* {
    final datasetDirectory = _datasetDirectory(dataset);
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

  Directory _datasetDirectory(Dataset dataset) => Directory.fromUri(
        _config.backupDir.uri.resolve(path.join(_config.host, dataset.name)),
      );
}
