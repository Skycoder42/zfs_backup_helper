// coverage:ignore-file

import 'dart:io';

import 'package:riverpod/riverpod.dart';

late final executableInfoProvider = Provider(
  (ref) => ExecutableInfo(),
);

class ExecutableInfo {
  String get executablePath => Platform.script.toFilePath();
}
