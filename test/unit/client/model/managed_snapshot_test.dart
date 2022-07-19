import 'package:dart_test_tools/test.dart';
import 'package:test/test.dart';
import 'package:tuple/tuple.dart';
import 'package:zfs_backup_helper/src/client/models/managed_snapshot.dart';

void main() {
  group('$ManagedSnapshot', () {
    testData<Tuple2<String, bool>>(
      'isManagedSnapshot correctly identifies matching snapshots',
      const [
        Tuple2('prefix_monthly-2020-10-10-1234', true),
        Tuple2('prefix_weekly-2020-10-10-1234', true),
        Tuple2('prefix_daily-2020-10-10-1234', true),
        Tuple2('long_daily_prefix_monthly-2020-10-10-1234', true),
        Tuple2('_monthly-2020-10-10-1234', true),
        Tuple2('prefix_yearly-2020-10-10-1234', false),
        Tuple2('prefix_monthly-100-10-10-1234', false),
        Tuple2('prefix_monthly-2020-5-10-1234', false),
        Tuple2('prefix_monthly-2020-10-3-1234', false),
        Tuple2('prefix_monthly-2020-10-10-20', false),
        Tuple2('prefix_monthly-2020-10-10-202020', false),
      ],
      (fixture) {
        expect(ManagedSnapshot.isManagedSnapshot(fixture.item1), fixture.item2);
      },
    );

    testData<Tuple2<String, ManagedSnapshot>>(
      'correctly converts snapshots from and to string',
      [
        Tuple2(
          'prefix_monthly-2020-10-08-1234',
          ManagedSnapshot(
            prefix: 'prefix',
            label: SnapshotLabel.monthly,
            timestamp: DateTime.utc(2020, 10, 8, 12, 34),
          ),
        ),
        Tuple2(
          'prefix_weekly-2020-10-08-1234',
          ManagedSnapshot(
            prefix: 'prefix',
            label: SnapshotLabel.weekly,
            timestamp: DateTime.utc(2020, 10, 8, 12, 34),
          ),
        ),
        Tuple2(
          'prefix_daily-2020-10-08-1234',
          ManagedSnapshot(
            prefix: 'prefix',
            label: SnapshotLabel.daily,
            timestamp: DateTime.utc(2020, 10, 8, 12, 34),
          ),
        ),
        Tuple2(
          '_monthly-2020-10-08-1234',
          ManagedSnapshot(
            prefix: '',
            label: SnapshotLabel.monthly,
            timestamp: DateTime.utc(2020, 10, 8, 12, 34),
          ),
        ),
        Tuple2(
          'long_daily_prefix_monthly-2020-10-08-1234',
          ManagedSnapshot(
            prefix: 'long_daily_prefix',
            label: SnapshotLabel.monthly,
            timestamp: DateTime.utc(2020, 10, 8, 12, 34),
          ),
        ),
        Tuple2(
          'prefix_monthly-0000-01-01-0000',
          ManagedSnapshot(
            prefix: 'prefix',
            label: SnapshotLabel.monthly,
            timestamp: DateTime.utc(0),
          ),
        ),
      ],
      (fixture) {
        expect(ManagedSnapshot.parse(fixture.item1), fixture.item2);
        expect(fixture.item2.toString(), fixture.item1);
      },
    );

    test('date returns timestamp without time information', () {
      final sut = ManagedSnapshot(
        prefix: 'prefix',
        label: SnapshotLabel.daily,
        timestamp: DateTime.utc(2010, 5, 8, 18, 55),
      );

      expect(sut.date, DateTime.utc(2010, 5, 8));
    });

    final compareSnapshot = ManagedSnapshot(
      prefix: 'prefix-B',
      label: SnapshotLabel.weekly,
      timestamp: DateTime.utc(2022, 11, 9, 10, 42),
    );
    testData<Tuple2<ManagedSnapshot, int>>(
      'correctly compares snapshots',
      [
        Tuple2(
          compareSnapshot.copyWith(),
          0,
        ),
        Tuple2(
          ManagedSnapshot(
            prefix: 'prefix-A',
            label: SnapshotLabel.daily,
            timestamp: DateTime.utc(2023, 11, 9, 10, 42),
          ),
          -1,
        ),
        Tuple2(
          ManagedSnapshot(
            prefix: 'prefix-C',
            label: SnapshotLabel.monthly,
            timestamp: DateTime.utc(2021, 11, 9, 10, 42),
          ),
          1,
        ),
        Tuple2(
          ManagedSnapshot(
            prefix: 'prefix-B',
            label: SnapshotLabel.monthly,
            timestamp: DateTime.utc(2023, 11, 9, 10, 42),
          ),
          -1,
        ),
        Tuple2(
          ManagedSnapshot(
            prefix: 'prefix-B',
            label: SnapshotLabel.daily,
            timestamp: DateTime.utc(2021, 11, 9, 10, 42),
          ),
          1,
        ),
        Tuple2(
          ManagedSnapshot(
            prefix: 'prefix-B',
            label: SnapshotLabel.weekly,
            timestamp: DateTime.utc(2021, 11, 9, 10, 42),
          ),
          -1,
        ),
        Tuple2(
          ManagedSnapshot(
            prefix: 'prefix-B',
            label: SnapshotLabel.weekly,
            timestamp: DateTime.utc(2023, 11, 9, 10, 42),
          ),
          1,
        ),
      ],
      (fixture) {
        final compareResult = fixture.item1.compareTo(compareSnapshot);
        expect(compareResult, fixture.item2);
      },
    );
  });
}
