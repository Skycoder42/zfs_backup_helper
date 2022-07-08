import 'remote/remote.dart';

class Client {
  final Remote _remote;

  Client(this._remote);

  Future<void> run(String rootDataset) async {
    final snapshots = _remote.listSnapshots(rootDataset);
    throw UnimplementedError(snapshots.toString());
    // get list of snapshots from server
    // pass snapshots to backup controller
    // backup controller interprets + sanitizes
  }
}
