import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'managed_snapshot.freezed.dart';

enum SnapshotLabel {
  monthly,
  weekly,
  daily,
}

@freezed
class ManagedSnapshot with _$ManagedSnapshot {
  static final _dateFormat = DateFormat('yyyy-MM-dd-HHmm');
  static final _snapshotRegexp = RegExp(
    r'^(.*)_(monthly|weekly|daily)-(\d{4}-\d{2}-\d{2}-\d{4})$',
  );

  ManagedSnapshot._();

  @Assert('timestamp.isUtc', 'timestamp must be a UTC timestamp')
  // ignore: sort_unnamed_constructors_first
  factory ManagedSnapshot({
    required String prefix,
    required SnapshotLabel label,
    required DateTime timestamp,
  }) = _ManagedSnapshot;

  factory ManagedSnapshot.parse(String snapshot) {
    final match = _snapshotRegexp.matchAsPrefix(snapshot);
    if (match == null) {
      throw ArgumentError.value(
        snapshot,
        'snapshot',
        'Invalid snapshot format',
      );
    }

    return ManagedSnapshot(
      prefix: match[1]!,
      label: SnapshotLabel.values.byName(match[2]!),
      timestamp: _dateFormat.parse(match[3]!, true),
    );
  }

  @override
  String toString() =>
      '${prefix}_${label.name}-${_dateFormat.format(timestamp)}';
}
