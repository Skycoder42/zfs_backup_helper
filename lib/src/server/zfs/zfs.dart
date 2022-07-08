import '../../common/managed_process.dart';

class Zfs {
  final ManagedProcess _managedProcess;

  Zfs(this._managedProcess);

  Stream<String> listSnapshots(String rootDataset) =>
      _managedProcess.run('zfs', [
        '-H',
        '-r',
        '-o',
        'name',
        '-t',
        'snapshot',
        rootDataset,
      ]);
}
