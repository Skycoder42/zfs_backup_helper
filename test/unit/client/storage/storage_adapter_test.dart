import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:zfs_backup_helper/src/client/models/config.dart';
import 'package:zfs_backup_helper/src/client/models/dataset.dart';
import 'package:zfs_backup_helper/src/client/models/managed_snapshot.dart';
import 'package:zfs_backup_helper/src/client/storage/storage_adapter.dart';

void main() {
  group('$StorageAdapter', () {
    const testHost = 'test-host.com';
    const testPrefix = 'test_prefix';
    const testDataset = Dataset('test/dataset');
    late Directory backupDir;

    late StorageAdapter sut;

    setUp(() async {
      backupDir = await Directory.systemTemp.createTemp();
      addTearDown(() => backupDir.delete(recursive: true));

      sut = StorageAdapter(
        Config(
          host: testHost,
          autoRoot: false,
          backupDir: backupDir,
          prefix: testPrefix,
        ),
      );
    });

    group('listSnapshots', () {
      test('returns empty stream if directory does not exist', () async {
        expect(sut.listSnapshots(testDataset), emitsDone);
      });

      test('returns stream of backup snapshots', () async {
        final expectedSnapshots = [
          ManagedSnapshot(
            prefix: testPrefix,
            label: SnapshotLabel.monthly,
            timestamp: DateTime.utc(2020, 10, 11, 12, 13),
          ),
          ManagedSnapshot(
            prefix: testPrefix,
            label: SnapshotLabel.weekly,
            timestamp: DateTime.utc(2020, 10, 11, 12, 31),
          ),
        ];

        final datasetDir = await Directory.fromUri(
          backupDir.uri.resolve('$testHost/${testDataset.name}'),
        ).create(recursive: true);
        await Directory.fromUri(datasetDir.uri.resolve('sub')).create();
        for (final snapshot in expectedSnapshots) {
          await File.fromUri(
            datasetDir.uri.resolve('$snapshot.backup'),
          ).create();
        }
        await File.fromUri(
          datasetDir.uri.resolve('other_prefix_daily-2000-01-01-0000.backup'),
        ).create();
        await File.fromUri(
          datasetDir.uri.resolve('${testPrefix}_daily-2000-01-01-0000'),
        ).create();
        await File.fromUri(
          datasetDir.uri.resolve('invalid.backup'),
        ).create();

        expect(
          sut.listSnapshots(testDataset),
          emitsInAnyOrder(<dynamic>[
            ...expectedSnapshots,
            emitsDone,
          ]),
        );
      });
    });

    group('storeSnapshot', () {
      final testSnapshot = ManagedSnapshot(
        prefix: testPrefix,
        label: SnapshotLabel.weekly,
        timestamp: DateTime.utc(2022, 4, 8, 16, 32),
      );

      final testStream = Stream.value([
        72,
        101,
        108,
        108,
        111,
        32,
        87,
        111,
        114,
        108,
        100,
      ]);

      test('stores snapshot as new file', () async {
        await sut.storeSnapshot(testDataset, testSnapshot, testStream);

        final snapshotFile = File.fromUri(
          backupDir.uri.resolve('$testHost/$testDataset/$testSnapshot.backup'),
        );
        expect(snapshotFile, _fileExists);
        expect(snapshotFile, _fileHasContent('Hello World'));
      });
    });
  });
}

Matcher _fileExists = predicate<File>((f) => f.existsSync(), 'file exists');

Matcher _fileHasContent(
  String content, {
  Encoding encoding = utf8,
}) =>
    predicate<File>(
      (f) => f.readAsStringSync(encoding: encoding) == content,
      'file has content: $content',
    );
