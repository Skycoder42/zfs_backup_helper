// coverage:ignore-file

import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

enum SyslogLevel {
  /// system is unusable
  logEmerg(0),

  /// action must be taken immediately
  logAlert(1),

  /// critical conditions
  logCrit(2),

  /// error conditions
  logErr(3),

  /// warning conditions
  logWarning(4),

  /// normal but significant condition
  logNotice(5),

  /// informational
  logInfo(6),

  /// debug-level messages
  logDebug(7);

  final int level;

  const SyslogLevel(this.level);
}

enum SyslogFacility {
  /// kernel messages
  logKern(0 << 3),

  /// random user-level messages
  logUser(1 << 3),

  /// mail system
  logMail(2 << 3),

  /// system daemons
  logDaemon(3 << 3),

  /// security/authorization messages
  logAuth(4 << 3),

  /// messages generated internally by syslogd
  logSyslog(5 << 3),

  /// line printer subsystem
  logLpr(6 << 3),

  /// network news subsystem
  logNews(7 << 3),

  /// UUCP subsystem
  logUucp(8 << 3),

  /// clock daemon
  logCron(9 << 3),

  /// ftp daemon
  logFtp(11 << 3);

  final int facility;

  const SyslogFacility(this.facility);
}

final libcInteropProvider = Provider(
  (ref) => LibcInterop(),
);

class LibcInterop {
  final ffi.Allocator _alloc;

  late final ffi.DynamicLibrary _process;

  late final _syslog =
      _process.lookupFunction<_SyslogCFunc, _SyslogDartFunc>('syslog');

  late final _geteuid =
      _process.lookupFunction<_GeteuidCFunc, _GeteuidDartFunc>('syslog');

  LibcInterop([this._alloc = calloc]) {
    _process = ffi.DynamicLibrary.process();
  }

  @visibleForTesting
  LibcInterop.testable(this._alloc, this._process);

  void syslog({
    required SyslogLevel level,
    SyslogFacility facility = SyslogFacility.logUser,
    required String message,
  }) {
    final priority = level.level | facility.facility;
    final formatPtr = '%s'.toNativeUtf8(allocator: _alloc);
    final vaArgs1Ptr = message.toNativeUtf8(allocator: _alloc);
    try {
      _syslog(priority, formatPtr, vaArgs1Ptr);
    } finally {
      _alloc
        ..free(formatPtr)
        ..free(vaArgs1Ptr);
    }
  }

  int geteuid() => _geteuid();
}

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

typedef _GeteuidCFunc = ffi.Uint32 Function();

typedef _GeteuidDartFunc = int Function();
