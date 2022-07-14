import 'dart:convert';

import 'package:riverpod/riverpod.dart';

import '../../common/logging/logger.dart';
import '../ffi/libc_interop.dart';

late final serverLoggerProvider = Provider<Logger>(
  (ref) => ServerLogger(
    ref.watch(
      libcInteropProvider,
    ),
  ),
);

class ServerLogger implements Logger {
  final LibcInterop _libcInterop;

  ServerLogger(this._libcInterop);

  @override
  void logInfo(String message) {
    _libcInterop.syslog(level: SyslogLevel.logInfo, message: message);
  }

  @override
  void logWarning(String message) {
    _libcInterop.syslog(level: SyslogLevel.logWarning, message: message);
  }

  @override
  void logException(Object exception, StackTrace stackStrace) {
    _libcInterop.syslog(
      level: SyslogLevel.logErr,
      message: '$exception\n$stackStrace',
    );
  }

  @override
  void logStderr(
    String commandLine,
    Stream<List<int>> stderr,
  ) {
    stderr
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .map((line) => '$commandLine: $line')
        .listen(
          (event) => _libcInterop.syslog(
            level: SyslogLevel.logWarning,
            message: event,
          ),
        );
  }
}
