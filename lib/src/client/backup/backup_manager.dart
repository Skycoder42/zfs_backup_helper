import 'package:riverpod/riverpod.dart';

import '../models/backup_task.dart';
import '../models/config.dart';
import '../models/dataset.dart';
import '../models/managed_snapshot.dart';
import '../remote/backup_server_adapter.dart';
import '../storage/storage_adapter.dart';
import 'backup_mode_selector.dart';
import 'snapshot_selector.dart';

final backupManagerProvider = Provider.family(
  (ref, Config config) => BackupManager(
    ref.watch(backupServerAdapterProvider(config)),
    ref.watch(storageAdapterProvider(config)),
    ref.watch(snapshotSelectorProvider(config)),
    ref.watch(backupModeSelectorProvider),
  ),
);

class BackupManager {
  final BackupServerAdapter _backupServerAdapter;
  final StorageAdapter _storageAdapter;

  final SnapshotSelector _snapshotSelector;
  final BackupModeSelector _backupModeSelector;

  BackupManager(
    this._backupServerAdapter,
    this._storageAdapter,
    this._snapshotSelector,
    this._backupModeSelector,
  );

  Future<List<BackupTask>> determineBackupTasks(Dataset rootDataset) async {
    final remoteTasks = await _backupServerAdapter.listBackupTasks(rootDataset);
    final existingSnapshots =
        await _storageAdapter.listSnapshots(rootDataset).toList();

    return _snapshotSelector.selectSnapshots(
      remoteTasks: remoteTasks,
      existingSnapshots: existingSnapshots,
    );
  }

  Future<void> executeTasks(List<BackupTask> backupTasks) async {
    for (final backupTask in backupTasks) {
      for (final snapshot in backupTask.snapshots) {
        await _runBackup(backupTask.dataset, snapshot);
      }
    }
  }

  Future<void> _runBackup(Dataset dataset, ManagedSnapshot snapshot) async {
    final existingSnapshots =
        await _storageAdapter.listSnapshots(dataset).toList();
    final backupMode = _backupModeSelector.selectBackupMode(
      snapshot: snapshot,
      existingSnapshots: existingSnapshots,
    );

    // TODO request snapshot from remote
    // TODO store snapshot locally
    // ignore: avoid_print
    print('Running backup for $dataset@$snapshot with mode: $backupMode');
  }
}
