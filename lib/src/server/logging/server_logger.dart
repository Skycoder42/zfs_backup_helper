import 'dart:convert';
import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import '../../common/logging/logger.dart';

typedef _SyslogCFunc = ffi.Void Function(
  ffi.Int priority,
  ffi.Pointer<Utf8> format,
  ffi.Pointer<Utf8> vaArgs1,
);

typedef _SyslogDartFunc = void Function(
  int priority,
  ffi.Pointer<Utf8> format,
  ffi.Pointer<Utf8> vaArgs1,
);

enum _SyslogLevel {
  logEmerg(0) /* system is unusable */,
  logAlert(1) /* action must be taken immediately */,
  logCrit(2) /* critical conditions */,
  logErr(3) /* error conditions */,
  logWarning(4) /* warning conditions */,
  logNotice(5) /* normal but significant condition */,
  logInfo(6) /* informational */,
  logDebug(7) /* debug-level messages */;

  final int level;

  const _SyslogLevel(this.level);
}

enum _SyslogFacility {
  logKern(0 << 3) /* kernel messages */,
  logUser(1 << 3) /* random user-level messages */,
  logMail(2 << 3) /* mail system */,
  logDaemon(3 << 3) /* system daemons */,
  logAuth(4 << 3) /* security/authorization messages */,
  logSyslog(5 << 3) /* messages generated internally by syslogd */,
  logLpr(6 << 3) /* line printer subsystem */,
  logNews(7 << 3) /* network news subsystem */,
  logUucp(8 << 3) /* UUCP subsystem */,
  logCron(9 << 3) /* clock daemon */,
  logFtp(11 << 3) /* ftp daemon */;

  final int facility;

  const _SyslogFacility(this.facility);
}

class ServerLogger implements Logger {
  final ffi.Allocator _alloc;

  late final ffi.DynamicLibrary _process;

  late final _SyslogDartFunc _syslogCFunc =
      _process.lookupFunction<_SyslogCFunc, _SyslogDartFunc>('syslog');

  ServerLogger([this._alloc = calloc]) {
    _process = ffi.DynamicLibrary.process();
  }

  @override
  void logException(Object exception, StackTrace stackStrace) {
    _syslog(level: _SyslogLevel.logErr, message: '$exception\n$stackStrace');
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
          (event) => _syslog(
            level: _SyslogLevel.logWarning,
            message: event,
          ),
        );
  }

  void _syslog({
    required _SyslogLevel level,
    _SyslogFacility facility = _SyslogFacility.logUser,
    required String message,
  }) {
    final priority = level.level | facility.facility;
    final formatPtr = '%s'.toNativeUtf8(allocator: _alloc);
    final vaArgs1Ptr = message.toNativeUtf8(allocator: _alloc);
    try {
      _syslogCFunc(priority, formatPtr, vaArgs1Ptr);
    } finally {
      _alloc
        ..free(formatPtr)
        ..free(vaArgs1Ptr);
    }
  }
}
