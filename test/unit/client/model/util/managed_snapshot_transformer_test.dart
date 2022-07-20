import 'dart:async';

import 'package:dart_test_tools/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:tuple/tuple.dart';
import 'package:zfs_backup_helper/src/client/models/managed_snapshot.dart';
import 'package:zfs_backup_helper/src/client/models/util/managed_snapshot_transformer.dart';

class MockEventSink<T> extends Mock implements EventSink<T> {}

void main() {
  group('$ManagedSnapshotTransformerSink', () {
    final mockSink = MockEventSink<ManagedSnapshot>();

    ManagedSnapshotTransformerSink createSut(String? prefix) =>
        ManagedSnapshotTransformerSink(prefix, mockSink);

    setUp(() {
      reset(mockSink);
    });

    testData<Tuple3<String?, String, ManagedSnapshot?>>(
      'correctly transforms snapshots',
      [
        Tuple3(
          null,
          'prefix_weekly-2002-10-11-1213',
          ManagedSnapshot(
            prefix: 'prefix',
            label: SnapshotLabel.weekly,
            timestamp: DateTime.utc(2002, 10, 11, 12, 13),
          ),
        ),
        Tuple3(
          null,
          'other_prefix_weekly-2002-10-11-1213',
          ManagedSnapshot(
            prefix: 'other_prefix',
            label: SnapshotLabel.weekly,
            timestamp: DateTime.utc(2002, 10, 11, 12, 13),
          ),
        ),
        Tuple3(
          'prefix',
          'prefix_weekly-2002-10-11-1213',
          ManagedSnapshot(
            prefix: 'prefix',
            label: SnapshotLabel.weekly,
            timestamp: DateTime.utc(2002, 10, 11, 12, 13),
          ),
        ),
        const Tuple3(
          'prefix',
          'other_prefix_weekly-2002-10-11-1213',
          null,
        ),
        const Tuple3(null, 'invalid', null),
      ],
      (fixture) {
        createSut(fixture.item1).add(fixture.item2);
        final addedItem = fixture.item3;
        if (addedItem != null) {
          verify(() => mockSink.add(addedItem));
        } else {
          verifyZeroInteractions(mockSink);
        }
      },
    );

    test('addError forwards error to sink', () {
      final error = Exception();
      final stackTrace = StackTrace.current;

      createSut(null).addError(error, stackTrace);

      verify(() => mockSink.addError(error, stackTrace));
    });

    test('close forwards close to sink', () {
      createSut(null).close();

      verify(() => mockSink.close());
    });
  });

  group('$ManagedSnapshotTransformer', () {
    test('bind creates event transformed stream', () {
      final snapshot = ManagedSnapshot(
        prefix: 'prefix',
        label: SnapshotLabel.daily,
        timestamp: DateTime.utc(1234, 5, 6, 7, 8),
      );
      const sut = ManagedSnapshotTransformer(null);
      final stream = sut.bind(Stream.value(snapshot.toString()));
      expect(
        stream,
        emitsInOrder(<dynamic>[
          snapshot,
          emitsDone,
        ]),
      );
    });

    test('extension creates event transformed stream', () {
      final snapshot = ManagedSnapshot(
        prefix: 'prefix',
        label: SnapshotLabel.daily,
        timestamp: DateTime.utc(1234, 5, 6, 7, 8),
      );
      final stream = Stream.value(snapshot.toString()).transformSnapshots(null);
      expect(
        stream,
        emitsInOrder(<dynamic>[
          snapshot,
          emitsDone,
        ]),
      );
    });
  });
}
