import '../models/backup_task.dart';

class BackupManager {
  Future<List<dynamic>> determineBackupTasks({
    required String rootDataset,
    required List<BackupTask> backupTasks,
  }) async {
    final rootBackup =
        backupTasks.where((backupTask) => backupTask.isRoot).single;

    throw UnimplementedError();
  }
}
