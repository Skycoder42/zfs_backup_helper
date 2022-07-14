import 'package:freezed_annotation/freezed_annotation.dart';

import 'dataset.dart';
import 'managed_snapshot.dart';

part 'backup_task.freezed.dart';

@freezed
class BackupTask with _$BackupTask {
  const factory BackupTask({
    required Dataset dataset,
    required List<ManagedSnapshot> snapshots,
    required bool isRoot,
  }) = _BackupTask;
}
