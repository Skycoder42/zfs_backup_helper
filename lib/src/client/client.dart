import 'package:riverpod/riverpod.dart';

import 'backup/backup_manager.dart';
import 'models/config.dart';
import 'remote/backup_server_adapter.dart';

late final clientProvider = Provider.family(
  (ref, Config config) => Client(
    ref.watch(backupServerAdapterProvider(config)),
    ref.watch(backupManagerProvider(config)),
  ),
);

class Client {
  final BackupServerAdapter _backupServerAdapter;
  final BackupManager _backupManager;

  Client(
    this._backupServerAdapter,
    this._backupManager,
  );

  Future<void> runBackup(String rootDataset) async {
    final snapshots = await _backupServerAdapter.listSnapshots(rootDataset);
    await _backupManager.determineBackupTasks(snapshots);

    // pass snapshots to backup controller
    // backup controller interprets + sanitizes
  }
}
