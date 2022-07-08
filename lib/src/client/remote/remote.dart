import '../../common/managed_process.dart';

class Remote {
  final ManagedProcess _managedProcess;

  final String hostName;
  final bool debugMode;

  Remote(
    this._managedProcess,
    this.hostName, {
    this.debugMode = false,
  });

  Stream<String> listSnapshots(String rootDataset) => _runRemote([
        'list-snapshots',
        '--root',
        rootDataset,
      ]);

  Stream<String> _runRemote(List<String> arguments) {
    if (debugMode) {
      return _managedProcess.run('dart', [
        'run',
        'bin/zfs_backup_server',
        ...arguments,
      ]);
    } else {
      return _managedProcess.run('ssh', [
        'zfs_backup_server',
        '--',
        hostName,
        ...arguments,
      ]);
    }
  }
}
