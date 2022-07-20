import 'dart:io';

import 'package:dart_test_tools/test.dart';
import 'package:test/test.dart';
import 'package:zfs_backup_helper/src/client/models/backup_task.dart';
import 'package:zfs_backup_helper/src/client/models/config.dart';
import 'package:zfs_backup_helper/src/client/models/dataset.dart';
import 'package:zfs_backup_helper/src/client/models/managed_snapshot.dart';
import 'package:zfs_backup_helper/src/client/remote/snapshot_parser.dart';

void main() {
  group('$SnapshotParser', () {
    const testPrefix = 'test-prefix';
    const testRootDataset = Dataset('root-dataset');

    late SnapshotParser sut;

    setUp(() {
      sut = SnapshotParser(
        Config(
          host: '',
          autoRoot: false,
          backupDir: Directory.systemTemp,
          prefix: testPrefix,
        ),
      );
    });

    group('parseSnapshotList', () {
      test('generates list of backup tasks from stream of snapshots', () async {
        final datasets = [
          testRootDataset,
          const Dataset('dataset1'),
          Dataset('$testRootDataset/dataset2')
        ];
        final snapshots = [
          ManagedSnapshot(
            prefix: testPrefix,
            label: SnapshotLabel.weekly,
            timestamp: DateTime.utc(2020),
          ),
          ManagedSnapshot(
            prefix: testPrefix,
            label: SnapshotLabel.monthly,
            timestamp: DateTime.utc(2020),
          ),
        ];
        final otherSnapshot = ManagedSnapshot(
          prefix: 'other-prefix',
          label: SnapshotLabel.monthly,
          timestamp: DateTime.utc(2020),
        );
        final snapshotStream = Stream.fromIterable([
          'empty-dataset@unknown-snapshot',
          for (final dataset in datasets)
            for (final snapshot in [...snapshots, otherSnapshot])
              '$dataset@$snapshot',
        ]);

        final result = await sut.parseSnapshotList(
          rootDataset: testRootDataset,
          snapshots: snapshotStream,
        );

        expect(result, hasLength(datasets.length));
        for (final dataset in datasets) {
          expect(result, contains(_hasDataset(dataset)));
        }
        for (final backupTask in result) {
          expect(backupTask.snapshots, orderedEquals(snapshots.reversed));
          expect(backupTask.isRoot, backupTask.dataset == testRootDataset);
        }
      });

      testData<String>(
        'throws exception for invalid dataset-snapshot-pairs',
        [
          '',
          'invalid-element',
          'another@invalid@element',
        ],
        (fixture) {
          expect(
            () => sut.parseSnapshotList(
              rootDataset: testRootDataset,
              snapshots: Stream.value(fixture),
            ),
            throwsA(isException),
          );
        },
      );
    });
  });
}

Matcher _hasDataset(Dataset dataset) => predicate<BackupTask>(
      (t) => t.dataset == dataset,
      'is backup task for $dataset',
    );
