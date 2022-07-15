import 'package:logging/logging.dart';
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

  final _logger = Logger('$BackupManager');

  BackupManager(
    this._backupServerAdapter,
    this._storageAdapter,
    this._snapshotSelector,
    this._backupModeSelector,
  );

  Future<List<BackupTask>> determineBackupTasks(Dataset rootDataset) async {
    _logger.info(
      'Determining snapshots of dataset "$rootDataset" to backup...',
    );
    final remoteTasks = await _backupServerAdapter.listBackupTasks(rootDataset);
    _logger.info(
      'Found ${remoteTasks.length} remote datasets for "$rootDataset"',
    );
    if (_logger.isLoggable(Level.FINE)) {
      for (final task in remoteTasks) {
        _logger.fine('> ${task.dataset}');
      }
    }
    final existingSnapshots =
        await _storageAdapter.listSnapshots(rootDataset).toList();

    return _snapshotSelector.selectSnapshots(
      remoteTasks: remoteTasks,
      existingSnapshots: existingSnapshots,
    );
  }

  Future<void> executeTasks(List<BackupTask> backupTasks) async {
    // run all tasks, but run root task last to ensure
    // only fully transferred snapshots are treated as such
    final rootTask = backupTasks.singleWhere((t) => t.isRoot);
    final otherTasks = backupTasks.where((t) => !t.isRoot);
    final reorderedBackupTasks = [...otherTasks, rootTask];

    for (final backupTask in reorderedBackupTasks) {
      for (final snapshot in backupTask.snapshots) {
        await _runBackup(backupTask.dataset, snapshot);
      }
    }
  }

  Future<void> _runBackup(Dataset dataset, ManagedSnapshot snapshot) async {
    _logger.info('Backing up "$dataset@$snapshot');

    final existingSnapshots =
        await _storageAdapter.listSnapshots(dataset).toList();
    final backupMode = _backupModeSelector.selectBackupMode(
      snapshot: snapshot,
      existingSnapshots: existingSnapshots,
    );
    _logger.info('Determined backup mode as: $backupMode');

    final zfsDataStream = _backupServerAdapter.sendSnapshot(
      dataset,
      snapshot,
      backupMode,
    );
    await _storageAdapter.storeSnapshot(dataset, snapshot, zfsDataStream);
    _logger.info('Completed backup of "$dataset@$snapshot');

    // TODO verify snapshot?
  }
}
