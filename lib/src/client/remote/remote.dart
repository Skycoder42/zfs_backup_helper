import 'package:riverpod/riverpod.dart';

import '../../common/env.dart';
import '../../common/managed_process.dart';

late final remoteProvider = Provider.family(
  (ref, String hostName) => Remote(
    ref.watch(managedProcessProvider),
    hostName,
  ),
);

class Remote {
  final ManagedProcess _managedProcess;

  final String hostName;

  Remote(
    this._managedProcess,
    this.hostName,
  );

  Stream<String> listSnapshots(String rootDataset) => _runRemote([
        'list-snapshots',
        '--root',
        rootDataset,
      ]);

  Stream<String> _runRemote(List<String> arguments) {
    if (isLocalDebugMode) {
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
