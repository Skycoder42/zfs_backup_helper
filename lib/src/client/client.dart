import 'package:riverpod/riverpod.dart';

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
    final snapshots = await _remote.listSnapshots(rootDataset);
    // ignore: avoid_print
    print(snapshots);
    // get list of snapshots from server
    // pass snapshots to backup controller
    // backup controller interprets + sanitizes
  }
}
