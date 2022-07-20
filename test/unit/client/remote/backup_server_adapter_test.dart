import 'package:dart_test_tools/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zfs_backup_helper/src/client/models/backup_mode.dart';
import 'package:zfs_backup_helper/src/client/models/backup_task.dart';
import 'package:zfs_backup_helper/src/client/models/dataset.dart';
import 'package:zfs_backup_helper/src/client/models/managed_snapshot.dart';
import 'package:zfs_backup_helper/src/client/remote/backup_server_adapter.dart';
import 'package:zfs_backup_helper/src/client/remote/remote_call.dart';
import 'package:zfs_backup_helper/src/client/remote/snapshot_parser.dart';
import 'package:zfs_backup_helper/src/server/commands/list_snapshots_command.dart';
import 'package:zfs_backup_helper/src/server/commands/send_snapshot_command.dart';

class MockRemoteCall extends Mock implements RemoteCall {}

class MockSnapshotParser extends Mock implements SnapshotParser {}

void main() {
  setUpAll(() {
    registerFallbackValue(const Dataset(''));
    registerFallbackValue(const Stream<String>.empty());
  });

  group('$BackupServerAdapter', () {
    const testRootDataset = Dataset('test-root-dataset');
    final mockRemoteCall = MockRemoteCall();
    final mockSnapshotParser = MockSnapshotParser();

    late BackupServerAdapter sut;

    setUp(() {
      reset(mockRemoteCall);
      reset(mockSnapshotParser);

      sut = BackupServerAdapter(mockRemoteCall, mockSnapshotParser);
    });

    test(
      'listBackupTasks calls remote with correct arguments and parses result',
      () async {
        final testStream = Stream.value('data');
        final testResult = [
          BackupTask(
            dataset: testRootDataset,
            isRoot: true,
            snapshots: [],
          ),
        ];

        when(() => mockRemoteCall.runRemoteLines(any(), any()))
            .thenStream(testStream);
        when(
          () => mockSnapshotParser.parseSnapshotList(
            rootDataset: any(named: 'rootDataset'),
            snapshots: any(named: 'snapshots'),
          ),
        ).thenReturnAsync(testResult);

        final result = await sut.listBackupTasks(testRootDataset);

        verifyInOrder([
          () => mockRemoteCall.runRemoteLines(
                ListSnapshotsCommand.commandName,
                {
                  ListSnapshotsCommand.datasetOption: testRootDataset,
                },
              ),
          () => mockSnapshotParser.parseSnapshotList(
                rootDataset: testRootDataset,
                snapshots: testStream,
              ),
        ]);
        expect(result, testResult);
      },
    );

    group('sendSnapshot', () {
      test(
        'for full backup calls remote with correct arguments',
        () async {
          const testDataset = Dataset('test-dataset');
          final testSnapshot = ManagedSnapshot(
            prefix: 'prefix',
            label: SnapshotLabel.monthly,
            timestamp: DateTime.utc(2222),
          );
          final testStream = Stream.value([10, 20, 30]);

          when(() => mockRemoteCall.runRemote(any(), any()))
              .thenStream(testStream);

          final result = sut.sendSnapshot(
            testDataset,
            testSnapshot,
            const BackupMode.full(),
          );

          verify(
            () => mockRemoteCall.runRemote(
              SendSnapshotCommand.commandName,
              {
                SendSnapshotCommand.datasetOption: testDataset,
                SendSnapshotCommand.snapshotOption: testSnapshot,
              },
            ),
          );
          expect(result, testStream);
        },
      );

      test(
        'for incremental backup calls remote with correct arguments',
        () async {
          const testDataset = Dataset('test-dataset');
          final testSnapshot = ManagedSnapshot(
            prefix: 'prefix',
            label: SnapshotLabel.monthly,
            timestamp: DateTime.utc(2222),
          );
          final testParentSnapshot = ManagedSnapshot(
            prefix: 'prefix',
            label: SnapshotLabel.weekly,
            timestamp: DateTime.utc(2010, 5, 18, 21, 59),
          );
          final testStream = Stream.value([10, 20, 30]);

          when(() => mockRemoteCall.runRemote(any(), any()))
              .thenStream(testStream);

          final result = sut.sendSnapshot(
            testDataset,
            testSnapshot,
            BackupMode.incremental(testParentSnapshot),
          );

          verify(
            () => mockRemoteCall.runRemote(
              SendSnapshotCommand.commandName,
              {
                SendSnapshotCommand.datasetOption: testDataset,
                SendSnapshotCommand.snapshotOption: testSnapshot,
                SendSnapshotCommand.incrementalOption: testParentSnapshot,
              },
            ),
          );
          expect(result, testStream);
        },
      );
    });
  });
}
