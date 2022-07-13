import 'package:collection/collection.dart';

import '../../common/api/models/snapshot.dart';
import '../models/managed_snapshot.dart';
import 'backup_task.dart';

class BackupManager {
  Future<List<dynamic>> determineBackupTasks({
    required String rootDataset,
    required List<Snapshot> snapshots,
  }) async {
    final backupTasks = _mapSnapshots(
      rootDataset: rootDataset,
      snapshots: snapshots,
    );
    final rootBackup =
        backupTasks.where((backupTask) => backupTask.isRoot).single;

    throw UnimplementedError();
  }

  List<BackupTask> _mapSnapshots({
    required String rootDataset,
    required List<Snapshot> snapshots,
  }) =>
      snapshots
          .groupListsBy((snapshot) => snapshot.dataset)
          .entries
          .map(
            (e) => BackupTask(
              dataset: e.key,
              snapshots: e.value
                  .map((snapshot) => ManagedSnapshot.parse(snapshot.name))
                  .toList(),
              isRoot: e.key == rootDataset,
            ),
          )
          .toList();
}
