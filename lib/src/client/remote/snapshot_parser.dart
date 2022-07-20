import 'package:collection/collection.dart' as collection;
import 'package:riverpod/riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../models/backup_task.dart';
import '../models/config.dart';
import '../models/dataset.dart';
import '../models/util/managed_snapshot_transformer.dart';

final snapshotParserProvider = Provider.family(
  (ref, Config config) => SnapshotParser(config),
);

class SnapshotParser {
  final Config _config;

  SnapshotParser(this._config);

  Future<List<BackupTask>> parseSnapshotList({
    required Dataset rootDataset,
    required Stream<String> snapshots,
  }) =>
      snapshots
          .map(_splitSnapshot)
          .groupMapBy(
            grouper: (snapshot) => snapshot.key,
            mapper: (snapshot) => snapshot.value,
          )
          .map((stream) => _mapBackupTask(stream, rootDataset))
          .flatMap(Stream.fromFuture)
          .where((backupTask) => backupTask.snapshots.isNotEmpty)
          .toList();

  MapEntry<String, String> _splitSnapshot(String snapshot) {
    final elements = snapshot.split('@');
    if (elements.length != 2) {
      throw Exception('Unexpected snapshot name: $snapshot');
    }

    return MapEntry(elements[0], elements[1]);
  }

  Future<BackupTask> _mapBackupTask(
    GroupedStream<String, String> snapshotStream,
    Dataset rootDataset,
  ) async {
    final parsedSnapshots =
        await snapshotStream.transformSnapshots(_config.prefix).toList();

    final dataset = Dataset(snapshotStream.key);
    return BackupTask(
      dataset: dataset,
      snapshots: parsedSnapshots.sorted(),
      isRoot: dataset == rootDataset,
    );
  }
}

extension _StreamGroupMapByX<TData> on Stream<TData> {
  Stream<GroupedStream<TValue, TKey>> groupMapBy<TKey, TValue>({
    required TKey Function(TData) grouper,
    required TValue Function(TData) mapper,
  }) =>
      groupBy(grouper).map(
        (stream) => GroupedStream(
          stream.key,
          stream.map(mapper),
        ),
      );
}
