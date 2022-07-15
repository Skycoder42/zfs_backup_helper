import 'package:collection/collection.dart';
import 'package:riverpod/riverpod.dart';

import '../models/backup_mode.dart';
import '../models/managed_snapshot.dart';

late final backupModeSelectorProvider = Provider(
  (ref) => BackupModeSelector(),
);

/// Backup policy:
///
/// 1. Quarterly full snapshot
/// 2. Monthly differential based on previous quarter
/// 3. Weekly differential based on previous month
/// 4. Daily incremental based on previous any
class BackupModeSelector {
  static const _quarterMonths = [1, 4, 7, 10];

  BackupMode selectBackupMode({
    required ManagedSnapshot snapshot,
    required List<ManagedSnapshot> existingSnapshots,
  }) {
    if (_isQuarterly(snapshot)) {
      return const BackupMode.full();
    }

    switch (snapshot.label) {
      case SnapshotLabel.monthly:
        return _findBackupMode(
          snapshot: snapshot,
          existingSnapshots: existingSnapshots,
          parentSnapshotFilter: _isQuarterly,
        );
      case SnapshotLabel.weekly:
        return _findBackupMode(
          snapshot: snapshot,
          existingSnapshots: existingSnapshots,
          parentSnapshotFilter: (s) => s.label == SnapshotLabel.monthly,
        );
      case SnapshotLabel.daily:
        return _findBackupMode(
          snapshot: snapshot,
          existingSnapshots: existingSnapshots,
          parentSnapshotFilter: (_) => true,
        );
    }
  }

  bool _isQuarterly(ManagedSnapshot snapshot) =>
      snapshot.label == SnapshotLabel.monthly &&
      _quarterMonths.contains(snapshot.timestamp.month);

  BackupMode _findBackupMode({
    required ManagedSnapshot snapshot,
    required List<ManagedSnapshot> existingSnapshots,
    required bool Function(ManagedSnapshot) parentSnapshotFilter,
  }) {
    final parentSnapshot = existingSnapshots
        .where((s) => s.prefix == snapshot.prefix)
        .where(parentSnapshotFilter)
        .where((s) => !s.timestamp.isAfter(snapshot.timestamp))
        .sorted()
        .lastOrNull;

    if (parentSnapshot == null) {
      return const BackupMode.full();
    } else {
      return BackupMode.incremental(parentSnapshot);
    }
  }
}
