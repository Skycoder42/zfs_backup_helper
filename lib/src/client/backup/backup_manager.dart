import 'package:riverpod/riverpod.dart';

import '../models/backup_task.dart';
import '../models/config.dart';
import 'snapshot_selector.dart';

final backupManagerProvider = Provider.family(
  (ref, Config config) => BackupManager(
    ref.watch(snapshotSelectorProvider(config)),
  ),
);

class BackupManager {
  final SnapshotSelector _snapshotSelector;

  BackupManager(this._snapshotSelector);

  Future<List<dynamic>> determineBackupTasks(
    List<BackupTask> backupTasks,
  ) async {
    final rootBackup =
        backupTasks.where((backupTask) => backupTask.isRoot).single;
    final snapshotsToSync = await _snapshotSelector.selectSnapshots(rootBackup);

    for (final snapshot in snapshotsToSync) {
      for (final backupTask in backupTasks) {
        // ignore: avoid_print
        print(
          // ignore: lines_longer_than_80_chars
          '${backupTask.dataset}@$snapshot: ${backupTask.snapshots.contains(snapshot)}',
        );
      }
    }

    throw UnimplementedError();
  }
}
