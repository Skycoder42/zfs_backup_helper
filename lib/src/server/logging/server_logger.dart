import 'dart:convert';

import 'package:riverpod/riverpod.dart';

import '../../common/process_logger.dart';
import '../ffi/libc_interop.dart';

late final serverLoggerProvider = Provider<ServerLogger>(
  (ref) => ServerLogger(
    ref.watch(
      libcInteropProvider,
    ),
  ),
);

late final serverProcessLoggerProvider = Provider<ProcessLogger>(
  (ref) => ref.watch(serverLoggerProvider),
);

class ServerLogger implements ProcessLogger {
  final LibcInterop _libcInterop;

  ServerLogger(this._libcInterop);

  void logException(Object exception, StackTrace stackStrace) {
    _libcInterop.syslog(
      level: SyslogLevel.logCrit,
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
