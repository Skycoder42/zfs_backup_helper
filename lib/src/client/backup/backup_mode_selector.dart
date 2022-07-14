import 'package:collection/collection.dart';
import 'package:riverpod/riverpod.dart';

import '../models/backup_mode.dart';
import '../models/managed_snapshot.dart';

late final backupModeSelectorProvider = Provider(
  (ref) => BackupModeSelector(),
);

/// Backup policy:
///
/// 1. Annually full snapshot
/// 2. Monthly incremental based on previous month
/// 3. Weekly incremental based on previous month or week
/// 4. Daily incremental based on previous any
class BackupModeSelector {
  BackupMode selectBackupMode({
    required ManagedSnapshot snapshot,
    required List<ManagedSnapshot> existingSnapshots,
  }) {
    switch (snapshot.label) {
      case SnapshotLabel.monthly:
        return _monthlyMode(
          snapshot: snapshot,
          existingSnapshots: existingSnapshots,
        );
      case SnapshotLabel.weekly:
        return _weeklyMode(
          snapshot: snapshot,
          existingSnapshots: existingSnapshots,
        );
      case SnapshotLabel.daily:
        return _dailyMode(
          snapshot: snapshot,
          existingSnapshots: existingSnapshots,
        );
    }
  }

  BackupMode _monthlyMode({
    required ManagedSnapshot snapshot,
    required List<ManagedSnapshot> existingSnapshots,
  }) {
    if (snapshot.timestamp.month == 1) {
      return const BackupMode.full();
    }

    final parentSnapshot = _findParent(
      snapshot: snapshot,
      existingSnapshots: existingSnapshots,
      filter: (s) => s.label == SnapshotLabel.monthly,
    );

    if (parentSnapshot == null) {
      return const BackupMode.full();
    } else {
      return BackupMode.incremental(parentSnapshot);
    }
  }

  BackupMode _weeklyMode({
    required ManagedSnapshot snapshot,
    required List<ManagedSnapshot> existingSnapshots,
  }) {
    final parentSnapshot = _findParent(
      snapshot: snapshot,
      existingSnapshots: existingSnapshots,
      filter: (s) =>
          s.label == SnapshotLabel.monthly || s.label == SnapshotLabel.weekly,
    );

    if (parentSnapshot == null) {
      return const BackupMode.full();
    } else {
      return BackupMode.incremental(parentSnapshot);
    }
  }

  BackupMode _dailyMode({
    required ManagedSnapshot snapshot,
    required List<ManagedSnapshot> existingSnapshots,
  }) {
    final parentSnapshot = _findParent(
      snapshot: snapshot,
      existingSnapshots: existingSnapshots,
      filter: (_) => true,
    );

    if (parentSnapshot == null) {
      return const BackupMode.full();
    } else {
      return BackupMode.incremental(parentSnapshot);
    }
  }

  ManagedSnapshot? _findParent({
    required ManagedSnapshot snapshot,
    required List<ManagedSnapshot> existingSnapshots,
    required bool Function(ManagedSnapshot) filter,
  }) =>
      existingSnapshots
          .where((s) => s.prefix == snapshot.prefix)
          .where(filter)
          .where((s) => s.timestamp.isBefore(snapshot.timestamp))
          .sorted()
          .lastOrNull;
}
