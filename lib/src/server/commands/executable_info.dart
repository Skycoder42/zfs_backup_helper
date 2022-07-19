// coverage:ignore-file

import 'dart:io';

import 'package:riverpod/riverpod.dart';

final executableInfoProvider = Provider(
  (ref) => ExecutableInfo(),
);

class ExecutableInfo {
  String get executablePath => Platform.script.toFilePath();
}
