import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/managed_snapshot.dart';

part 'backup_task.freezed.dart';

@freezed
class BackupTask with _$BackupTask {
  const factory BackupTask({
    required String dataset,
    required List<ManagedSnapshot> snapshots,
    required bool isRoot,
  }) = _BackupTask;
}
