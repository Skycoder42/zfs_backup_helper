import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zfs_backup_helper/src/server/ffi/libc_interop.dart';
import 'package:zfs_backup_helper/src/server/logging/server_logger.dart';

class MockLibcInterop extends Mock implements LibcInterop {}

void main() {
  group('$ServerLogger', () {
    final mockLibcInterop = MockLibcInterop();

    late ServerLogger sut;

    setUp(() {
      reset(mockLibcInterop);

      sut = ServerLogger(mockLibcInterop);
    });

    test('logException logs error with stacktrace to syslog', () {
      final exception = Exception('failure');
      final stackTrace = StackTrace.current;

      sut.logException(exception, stackTrace);

      verify(
        () => mockLibcInterop.syslog(
          level: SyslogLevel.logErr,
          message: '$exception\n$stackTrace',
        ),
      );
    });

    test('logStderr maps error lines to syslog warnings', () async {
      const commandLine = 'executable arg1 arg2';
      const stderrText = 'error1\nerror2\nerror3\n';
      final stderr = Stream.value(stderrText).transform(utf8.encoder);

      await sut.logStderr(commandLine, stderr).asFuture<void>();

      verifyInOrder([
        () => mockLibcInterop.syslog(
              level: SyslogLevel.logWarning,
              message: '$commandLine: error1',
            ),
        () => mockLibcInterop.syslog(
              level: SyslogLevel.logWarning,
              message: '$commandLine: error2',
            ),
        () => mockLibcInterop.syslog(
              level: SyslogLevel.logWarning,
              message: '$commandLine: error3',
            ),
      ]);
      verifyNoMoreInteractions(mockLibcInterop);
    });
  });
}
