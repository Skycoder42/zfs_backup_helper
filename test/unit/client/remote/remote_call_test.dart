import 'dart:convert';
import 'dart:io';

import 'package:dart_test_tools/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zfs_backup_helper/src/client/models/config.dart';
import 'package:zfs_backup_helper/src/client/remote/remote_call.dart';
import 'package:zfs_backup_helper/src/common/managed_process.dart';

class MockManagedProcess extends Mock implements ManagedProcess {}

void main() {
  group('$RemoteCall', () {
    const testHost = 'test.host.org';

    final mockManagedProcess = MockManagedProcess();

    RemoteCall _createSut({required bool autoRoot}) => RemoteCall(
          mockManagedProcess,
          Config(
            host: testHost,
            autoRoot: autoRoot,
            backupDir: Directory.systemTemp,
            prefix: '',
          ),
        );

    setUp(() {
      reset(mockManagedProcess);
    });

    group('runRemote', () {
      const testCommand = 'test-command';
      const testArguments = {
        'arg1': 'value1',
        'arg2': 42,
        'arg3': null,
        'arg4': true,
      };

      test('runs ssh on remote host with auto root disabled', () {
        final data = Stream.value([1, 2, 3]);

        when(() => mockManagedProcess.runRaw(any(), any())).thenStream(data);

        final sut = _createSut(autoRoot: false);
        final result = sut.runRemote(testCommand, testArguments);

        verify(
          () => mockManagedProcess.runRaw('ssh', const [
            testHost,
            '--',
            'zfs_backup_server',
            testCommand,
            '--arg1',
            'value1',
            '--arg2',
            '42',
            '--arg3',
            '--arg4',
            'true',
          ]),
        );
        expect(result, same(data));
      });

      test('runs ssh on remote host with auto root enabled', () {
        final data = Stream.value([1, 2, 3]);

        when(() => mockManagedProcess.runRaw(any(), any())).thenStream(data);

        final sut = _createSut(autoRoot: true);
        final result = sut.runRemote(testCommand, testArguments);

        verify(
          () => mockManagedProcess.runRaw('ssh', const [
            testHost,
            '--',
            'zfs_backup_server',
            '--root',
            testCommand,
            '--arg1',
            'value1',
            '--arg2',
            '42',
            '--arg3',
            '--arg4',
            'true',
          ]),
        );
        expect(result, same(data));
      });
    });

    group('runRemoteLines', () {
      test('transforms result data to string lines', () {
        final data =
            Stream.value('line1\nline2 🧑‍💻\n\nline3').transform(utf8.encoder);

        when(() => mockManagedProcess.runRaw(any(), any())).thenStream(data);

        final sut = _createSut(autoRoot: false);
        final result = sut.runRemoteLines('command', {});

        expect(
          result,
          emitsInOrder(<dynamic>[
            'line1',
            'line2 🧑‍💻',
            '',
            'line3',
            emitsDone,
          ]),
        );
      });

      test('transforms result data to string lines with custom encoding', () {
        final data =
            Stream.value('line1\nline2Ä\n\nline3').transform(latin1.encoder);

        when(() => mockManagedProcess.runRaw(any(), any())).thenStream(data);

        final sut = _createSut(autoRoot: false);
        final result = sut.runRemoteLines(
          'command',
          {},
          encoding: latin1,
        );

        expect(
          result,
          emitsInOrder(<dynamic>[
            'line1',
            'line2Ä',
            '',
            'line3',
            emitsDone,
          ]),
        );
      });
    });
  });
}
