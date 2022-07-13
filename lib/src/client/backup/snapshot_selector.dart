import '../storage/storage.dart';
import 'backup_task.dart';

class SnapshotSelector {
  final Storage _storage;

  Future<List<String>> selectSnapshots(BackupTask rootTask) async {
    final existingSnapshots =
        await _storage.listSnapshots(rootTask.dataset).toList();

    // TODO check existing snapshots for required snapshots
  }
}
