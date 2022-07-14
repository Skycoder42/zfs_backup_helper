import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'config.freezed.dart';

@freezed
class Config with _$Config {
  const factory Config({
    required String host,
    required bool autoRoot,
    required Directory backupDir,
    required String? prefix,
  }) = _Config;
}
