import 'dart:async';

import '../../common/api/commands/list_snapshots_command.dart';
import '../../common/api/models/snapshot.dart';
import 'remote_command.dart';

class ListSnapshotsRemoteCommand extends RemoteCommand
    implements ListSnapshotsCommand {
  ListSnapshotsRemoteCommand(super._managedProcess, super.hostName);

  @override
  FutureOr<List<Snapshot>> call(ListSnapshotRequest request) =>
      runRemoteJson(decoder: Snapshot.fromJsonList, [
        'list-snapshots',
        '--root',
        request.rootDataset,
      ]);
}
