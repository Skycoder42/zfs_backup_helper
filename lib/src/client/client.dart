import 'package:riverpod/riverpod.dart';

import '../common/api/commands/list_snapshots_command.dart';
import 'remote/remote.dart';

late final clientProvider = Provider.family(
  (ref, String hostName) => Client(
    ref.watch(
      remoteProvider(hostName),
    ),
  ),
);

class Client {
  final Remote _remote;

  Client(this._remote);

  Future<void> runBackup(String rootDataset) async {
    final snapshots = await _remote
        .listSnapshots(ListSnapshotRequest(rootDataset: rootDataset));
    // ignore: avoid_print
    print(snapshots);
    // pass snapshots to backup controller
    // backup controller interprets + sanitizes
  }
}
