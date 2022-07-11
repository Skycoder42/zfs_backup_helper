import 'dart:async';
import 'dart:io' as io;

import '../../common/logging/logger.dart';

class ClientLogger implements Logger {
  @override
  void logStderr(
    String executable,
    List<String> arguments,
    Stream<List<int>> stderr,
  ) {
    stderr.listen(
      io.stderr.add,
      cancelOnError: false,
    );
  }
}
