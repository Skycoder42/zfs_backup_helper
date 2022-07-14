import 'dart:async';
import 'dart:io' as io;

import '../../common/logging/logger.dart';

class ClientLogger implements Logger {
  @override
  void logInfo(String message) {
    io.stderr.writeln('INFO: $message');
  }

  @override
  void logWarning(String message) {
    io.stderr.writeln('WARNING: $message');
  }

  @override
  void logException(Object exception, StackTrace stackStrace) {
    io.stderr.writeln('EXCEPTION: $exception');
    io.stderr.writeln('Stacktrace: $stackStrace');
  }

  @override
  void logStderr(
    String commandLine,
    Stream<List<int>> stderr,
  ) {
    stderr.listen(
      io.stderr.add,
      cancelOnError: false,
    );
  }
}
