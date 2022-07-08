import '../../common/managed_process.dart';

class Remote {
  final ManagedProcess _managedProcess;

  final String hostName;

  Remote(this._managedProcess, this.hostName);

  Stream<String> listSnapshots(String rootDataset) =>
      _managedProcess.run('ssh', [
        '--',
        hostName,
        'zfs_backup_server',
        'list-snapshots',
        '--root',
        rootDataset,
      ]);
}
