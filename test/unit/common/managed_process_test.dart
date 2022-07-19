import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zfs_backup_helper/src/common/managed_process.dart';
import 'package:zfs_backup_helper/src/common/process_logger.dart';

class MockProcessLogger extends Mock implements ProcessLogger {}

void main() {
  setUpAll(() {
    registerFallbackValue(const Stream<List<int>>.empty());
  });

  group('$ManagedProcess', () {
    final mockProcessLogger = MockProcessLogger();

    late ManagedProcess sut;

    setUp(() {
      reset(mockProcessLogger);

      sut = ManagedProcess(mockProcessLogger);
    });

    group('runRaw', () {
      test('runs executable and returns output', () async {
        final stdout = sut.runRaw(
          '/bin/sh',
          const ['-c', 'echo test; echo hello world'],
        );
        final stdoutString = await stdout.transform(utf8.decoder).join();
        expect(stdoutString, 'test\nhello world\n');
      });

      test('throws exception if exit code is not 0', () async {
        const executable = '/bin/sh';
        const exitCode = 5;
        const arguments = ['-c', 'echo A; exit $exitCode'];
        final stdout = sut.runRaw(
          executable,
          arguments,
        );

        expect(
          stdout,
          emitsInOrder(<dynamic>[
            [65, 10], // A\n
            emitsError(
              isA<ProcessFailure>()
                  .having((f) => f.executable, 'executable', executable)
                  .having((f) => f.arguments, 'arguments', arguments)
                  .having((f) => f.exitCode, 'exitCode', exitCode),
            ),
            emitsDone,
          ]),
        );
      });

      test('logs stderr to logger', () async {
        final stdout = sut.runRaw(
          '/bin/sh',
          const ['-c', '>&2 echo "test error"'],
        );

        await expectLater(stdout, emitsDone);

        final stderr = verify(
          () => mockProcessLogger.logStderr(
            '/bin/sh -c >&2 echo "test error"',
            captureAny(),
          ),
        ).captured.single as Stream<List<int>>;

        final stderrString = await stderr.transform(utf8.decoder).join();
        expect(stderrString, 'test error\n');
      });
    });
  });

  group('$ProcessFailure', () {
    test('toString prints correct string', () {
      final error = ProcessFailure(
        executable: '/bin/exe',
        arguments: ['a', 'b', 'c'],
        exitCode: 42,
      );

      expect(error.toString(), '/bin/exe a b c failed with exit code: 42');
    });
  });
}
