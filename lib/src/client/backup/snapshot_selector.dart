import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:riverpod/riverpod.dart';

import '../models/backup_task.dart';
import '../models/config.dart';
import '../models/managed_snapshot.dart';

final snapshotSelectorProvider = Provider.family(
  (ref, Config config) => SnapshotSelector(config),
);

class SnapshotSelector {
  final Config _config;
  final _logger = Logger('$SnapshotSelector');

  SnapshotSelector(this._config);

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
    _logger.info(
      'Determined ${snapshotsToBackup.length} snapshots to backup',
    );
    if (_logger.isLoggable(Level.FINE)) {
      for (final snapshot in snapshotsToBackup) {
        _logger.fine('> $snapshot');
      }
    }

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
      _logger.warning(
        'Skipping backup of missing snapshot: ${backupTask.dataset}@$snapshot',
      );
    }

    final additionalSnaps = taskSnapshots.difference(snapshotsToSync);
    for (final snapshot in additionalSnaps) {
      _logger.warning(
        'Skipping backup of unexpected snapshot: '
        '${backupTask.dataset}@$snapshot',
      );
    }

    return backupTask.copyWith(
      snapshots: snapshotsToSync.intersection(taskSnapshots).sorted(),
    );
  }
}
