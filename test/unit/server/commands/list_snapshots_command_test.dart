import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zfs_backup_helper/src/common/managed_process.dart';
import 'package:zfs_backup_helper/src/server/commands/list_snapshots_command.dart';

class MockManagedProcess extends Mock implements ManagedProcess {}

class MockArgResults extends Mock implements ArgResults {}

class SutListSnapshotsCommand extends ListSnapshotsCommand {
  @override
  final ArgResults argResults;

  @override
  Never usageException(String message) =>
      throw UsageException(message, 'usage');

  SutListSnapshotsCommand(super.managedProcess, this.argResults);
}

void main() {
  group('$ListSnapshotsCommand', () {
    final mockManagedProcess = MockManagedProcess();
    final mockArgResults = MockArgResults();

    late SutListSnapshotsCommand sut;

    setUp(() {
      reset(mockManagedProcess);
      reset(mockArgResults);

      sut = SutListSnapshotsCommand(mockManagedProcess, mockArgResults);
    });

    test('correctly configures parser', () {
      expect(sut.name, ListSnapshotsCommand.commandName);
      expect(sut.description, isNotEmpty);
      expect(sut.takesArguments, isFalse);

      final parser = sut.argParser;
      expect(parser.options, hasLength(2));
      expect(parser.options, contains('help'));
      expect(parser.options, contains(ListSnapshotsCommand.datasetOption));
    });

    group('run', () {
      test('throws UsageException if dataset option is not given', () {
        expect(() => sut.run(), throwsA(isA<UsageException>()));
      });

      test('invokes zfs to list all snapshots for the given dataset', () {
        const rootDataset = 'root-dataset';
        final data = Stream.value([2, 4, 6]);

        when<dynamic>(() => mockArgResults[ListSnapshotsCommand.datasetOption])
            .thenReturn(rootDataset);
        when(() => mockManagedProcess.runRaw(any(), any()))
            .thenAnswer((i) => data);

        final result = sut.run();

        verifyInOrder<dynamic>([
          () => mockArgResults[ListSnapshotsCommand.datasetOption],
          () => mockManagedProcess.runRaw('zfs', const [
                'list',
                '-H',
                '-r',
                '-o',
                'name',
                '-t',
                'snapshot',
                rootDataset
              ]),
        ]);
        expect(result, same(data));
      });
    });
  });
}
