import 'package:collection/collection.dart';

import '../models/backup_task.dart';
import '../storage/storage.dart';

class SnapshotSelector {
  final Storage _storage;

  SnapshotSelector(this._storage);

  Future<dynamic> selectSnapshots(BackupTask rootTask) async {
    final existingSnapshots =
        await _storage.listSnapshots(rootTask.dataset).toList();

    final newSnapshots = rootTask.snapshots
        .groupListsBy((snapshot) => snapshot.date)
        .values
        .map((snapshots) => snapshots.sorted().first)
        .toSet()
        .difference(existingSnapshots.toSet())
        .sorted(Comparable.compare);

    // TODO check existing snapshots for required snapshots
    throw UnimplementedError(newSnapshots.toString());
  }
}
