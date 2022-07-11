import 'package:riverpod/riverpod.dart';

import '../../common/api/api.dart';
import '../../common/api/models/snapshot.dart';
import '../../common/env.dart';
import '../../common/managed_process.dart';

late final remoteProvider = Provider.family(
  (ref, String hostName) => Remote(
    ref.watch(managedProcessProvider),
    hostName,
  ),
);

class Remote implements BackupApi {
  final ManagedProcess _managedProcess;

  final String hostName;

  Remote(
    this._managedProcess,
    this.hostName,
  );

  @override
  Future<List<Snapshot>> listSnapshots(String rootDataset) => _runRemote([
        'list-snapshots',
        '--root',
        rootDataset,
      ]);

  Future<List<Snapshot>> _runRemote(List<String> arguments) {
    if (isLocalDebugMode) {
      return _managedProcess.runJson(
        decoder: Snapshot.fromJsonList,
        'dart',
        [
          'run',
          'bin/zfs_backup_server.dart',
          ...arguments,
        ],
      );
    } else {
      return _managedProcess.runJson(
        decoder: Snapshot.fromJsonList,
        'ssh',
        [
          'zfs_backup_server',
          '--',
          hostName,
          ...arguments,
        ],
      );
    }
  }
}
