import 'package:riverpod/riverpod.dart';

import '../../common/api/api.dart';
import '../../common/api/commands/list_snapshots_command.dart';
import '../../common/managed_process.dart';
import 'list_snapshots_remote_command.dart';

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
  late final ListSnapshotsCommand listSnapshots =
      ListSnapshotsRemoteCommand(_managedProcess, hostName);
}
