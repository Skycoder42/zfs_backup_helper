import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zfs_backup_helper/src/common/managed_process.dart';
import 'package:zfs_backup_helper/src/server/commands/executable_info.dart';
import 'package:zfs_backup_helper/src/server/commands/send_snapshot_command.dart';
import 'package:zfs_backup_helper/src/server/ffi/libc_interop.dart';

class MockManagedProcess extends Mock implements ManagedProcess {}

class MockLibcInterop extends Mock implements LibcInterop {}

class MockExecutableInfo extends Mock implements ExecutableInfo {}

class MockArgResults extends Mock implements ArgResults {}

class SutSendSnapshotCommand extends SendSnapshotCommand {
  @override
  final ArgResults argResults;

  @override
  Never usageException(String message) =>
      throw UsageException(message, 'usage');

  SutSendSnapshotCommand(
    super.managedProcess,
    super._libcInterop,
    super._executableInfo,
    this.argResults,
  );
}

void main() {
  group('$SendSnapshotCommand', () {
    final mockManagedProcess = MockManagedProcess();
    final mockLibcInterop = MockLibcInterop();
    final mockExecutableInfo = MockExecutableInfo();
    final mockArgResults = MockArgResults();

    late SutSendSnapshotCommand sut;

    setUp(() {
      reset(mockManagedProcess);
      reset(mockLibcInterop);
      reset(mockExecutableInfo);
      reset(mockArgResults);

      sut = SutSendSnapshotCommand(
        mockManagedProcess,
        mockLibcInterop,
        mockExecutableInfo,
        mockArgResults,
      );
    });

    test('correctly configures parser', () {
      expect(sut.name, SendSnapshotCommand.commandName);
      expect(sut.description, isNotEmpty);
      expect(sut.takesArguments, isFalse);

      final parser = sut.argParser;
      expect(parser.options, hasLength(4));
      expect(parser.options, contains('help'));
      expect(parser.options, contains(SendSnapshotCommand.datasetOption));
      expect(parser.options, contains(SendSnapshotCommand.snapshotOption));
      expect(parser.options, contains(SendSnapshotCommand.incrementalOption));
    });

    group('runAsRoot', () {
      test('throws usage error if dataset option is not given', () {
        when<dynamic>(() => mockArgResults[SendSnapshotCommand.datasetOption])
            .thenReturn(null);
        when<dynamic>(() => mockArgResults[SendSnapshotCommand.snapshotOption])
            .thenReturn('snapshot');

        expect(() => sut.runAsRoot(), throwsA(isA<UsageException>()));
      });

      test('throws usage error if snapshot option is not given', () {
        when<dynamic>(() => mockArgResults[SendSnapshotCommand.datasetOption])
            .thenReturn('dataset');
        when<dynamic>(() => mockArgResults[SendSnapshotCommand.snapshotOption])
            .thenReturn(null);

        expect(() => sut.runAsRoot(), throwsA(isA<UsageException>()));
      });

      test(
        'Runs zfs send in full mode if only dataset and snapshot are given',
        () {
          const datasetName = 'dataset';
          const snapshotName = 'snapshot';
          final data = Stream.value([1, 5, 10]);

          when<dynamic>(() => mockArgResults[SendSnapshotCommand.datasetOption])
              .thenReturn(datasetName);
          when<dynamic>(
            () => mockArgResults[SendSnapshotCommand.snapshotOption],
          ).thenReturn(snapshotName);
          when(() => mockManagedProcess.runRaw(any(), any()))
              .thenAnswer((i) => data);

          final result = sut.runAsRoot();

          verifyInOrder<dynamic>([
            () => mockArgResults[SendSnapshotCommand.datasetOption],
            () => mockArgResults[SendSnapshotCommand.snapshotOption],
            () => mockArgResults[SendSnapshotCommand.incrementalOption],
            () => mockManagedProcess.runRaw('zfs', const [
                  'send',
                  '--verbose',
                  '--raw',
                  '$datasetName@$snapshotName',
                ]),
          ]);
          expect(result, same(data));
        },
      );

      test(
        'Runs zfs send in incremental mode if all options are given',
        () {
          const datasetName = 'dataset';
          const snapshotName = 'snapshot';
          const incrementalSnapshotName = 'parent-snapshot';
          final data = Stream.value([1, 5, 10]);

          when<dynamic>(() => mockArgResults[SendSnapshotCommand.datasetOption])
              .thenReturn(datasetName);
          when<dynamic>(
            () => mockArgResults[SendSnapshotCommand.snapshotOption],
          ).thenReturn(snapshotName);
          when<dynamic>(
            () => mockArgResults[SendSnapshotCommand.incrementalOption],
          ).thenReturn(incrementalSnapshotName);
          when(() => mockManagedProcess.runRaw(any(), any()))
              .thenAnswer((i) => data);

          final result = sut.runAsRoot();

          verifyInOrder<dynamic>([
            () => mockArgResults[SendSnapshotCommand.datasetOption],
            () => mockArgResults[SendSnapshotCommand.snapshotOption],
            () => mockArgResults[SendSnapshotCommand.incrementalOption],
            () => mockManagedProcess.runRaw('zfs', const [
                  'send',
                  '--verbose',
                  '--raw',
                  '-i',
                  '@$incrementalSnapshotName',
                  '$datasetName@$snapshotName',
                ]),
          ]);
          expect(result, same(data));
        },
      );
    });
  });
}
