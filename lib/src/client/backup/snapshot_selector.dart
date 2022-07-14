import 'package:collection/collection.dart';
import 'package:riverpod/riverpod.dart';

import '../models/backup_task.dart';
import '../models/config.dart';
import '../models/managed_snapshot.dart';
import '../storage/storage.dart';

late final snapshotSelectorProvider = Provider.family(
  (ref, Config config) => SnapshotSelector(
    ref.watch(storageProvider(config)),
  ),
);

class SnapshotSelector {
  final Storage _storage;

  SnapshotSelector(this._storage);

  Future<List<ManagedSnapshot>> selectSnapshots(BackupTask rootTask) async {
    final existingSnapshots =
        await _storage.listSnapshots(rootTask.dataset).toList();

    return rootTask.snapshots
        .toSet()
        .difference(existingSnapshots.toSet())
        .sorted();
  }
}
