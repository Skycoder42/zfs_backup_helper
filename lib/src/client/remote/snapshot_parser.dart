import 'package:riverpod/riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../models/backup_task.dart';
import '../models/dataset.dart';
import '../models/managed_snapshot.dart';

late final snapshotParserProvider = Provider(
  (ref) => SnapshotParser(),
);

class SnapshotParser {
  Future<List<BackupTask>> parseSnapshotList({
    required String rootDataset,
    required Stream<String> snapshots,
  }) =>
      snapshots
          .map(_splitSnapshot)
          .groupMapBy(
            grouper: (snapshot) => snapshot.key,
            mapper: (snapshot) => snapshot.value,
          )
          .map((stream) => _mapBackupTask(stream, rootDataset))
          .flatMap((value) => Stream.fromFuture(value))
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
    String rootDataset,
  ) async =>
      BackupTask(
        dataset: Dataset(snapshotStream.key),
        snapshots: await snapshotStream
            .map((snapshot) => ManagedSnapshot.parse(snapshot))
            .toList(),
        isRoot: snapshotStream.key == rootDataset,
      );
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
