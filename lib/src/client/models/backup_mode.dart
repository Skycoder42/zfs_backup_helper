import 'package:freezed_annotation/freezed_annotation.dart';

import 'managed_snapshot.dart';

part 'backup_mode.freezed.dart';

@freezed
class BackupMode with _$BackupMode {
  const factory BackupMode.full() = _FullBackup;
  const factory BackupMode.incremental(ManagedSnapshot parent) =
      _IncrementalBackup;
}
