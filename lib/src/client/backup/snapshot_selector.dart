import 'package:collection/collection.dart';
import 'package:riverpod/riverpod.dart';

import '../../common/logging/logger.dart';
import '../models/backup_task.dart';
import '../models/config.dart';
import '../models/managed_snapshot.dart';

late final snapshotSelectorProvider = Provider.family(
  (ref, Config config) => SnapshotSelector(
    ref.watch(loggerProvider),
    config,
  ),
);

class SnapshotSelector {
  final Logger _logger;
  final Config _config;

  SnapshotSelector(this._logger, this._config);

  Future<List<BackupTask>> selectSnapshots({
    required List<BackupTask> remoteTasks,
    required List<ManagedSnapshot> existingSnapshots,
  }) async {
    final snapshotsToBackup = remoteTasks
        .singleWhere((t) => t.isRoot)
        .snapshots
        .where(_filterByPrefix)
        .toSet()
        .difference(existingSnapshots.toSet());

    if (snapshotsToBackup.isEmpty) {
      return const [];
    }

    return remoteTasks
        .map((t) => _filterBackupableSnapshots(t, snapshotsToBackup))
        .where((t) => t.snapshots.isNotEmpty)
        .toList(growable: false);
  }

  bool _filterByPrefix(ManagedSnapshot managedSnapshot) {
    final prefix = _config.prefix;
    if (prefix == null) {
      return true;
    }

    return managedSnapshot.prefix == prefix;
  }

  BackupTask _filterBackupableSnapshots(
    BackupTask backupTask,
    Set<ManagedSnapshot> snapshotsToSync,
  ) {
    final taskSnapshots = backupTask.snapshots.toSet();

    final missingSnaps = snapshotsToSync.difference(taskSnapshots);
    for (final snapshot in missingSnaps) {
      _logger.logWarning(
        'Skipping missing snapshot: ${backupTask.dataset}@$snapshot',
      );
    }

    final additionalSnaps = taskSnapshots.difference(snapshotsToSync);
    for (final snapshot in additionalSnaps) {
      _logger.logWarning(
        'Skipping unexpected snapshot: ${backupTask.dataset}@$snapshot',
      );
    }

    return backupTask.copyWith(
      snapshots: snapshotsToSync.intersection(taskSnapshots).sorted(),
    );
  }
}
