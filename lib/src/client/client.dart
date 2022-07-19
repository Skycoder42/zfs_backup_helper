import 'package:riverpod/riverpod.dart';

import 'backup/backup_manager.dart';
import 'models/config.dart';
import 'models/dataset.dart';

final clientProvider = Provider.family(
  (ref, Config config) => Client(
    ref.watch(backupManagerProvider(config)),
  ),
);

class Client {
  final BackupManager _backupManager;

  Client(
    this._backupManager,
  );

  Future<void> runBackup(Dataset rootDataset) async {
    final localTasks = await _backupManager.determineBackupTasks(rootDataset);
    await _backupManager.executeTasks(localTasks);
  }
}
