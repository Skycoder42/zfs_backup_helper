import 'package:freezed_annotation/freezed_annotation.dart';

import '../util/combine_comparable.dart';

part 'managed_snapshot.freezed.dart';

enum SnapshotLabel {
  monthly,
  weekly,
  daily,
}

@freezed
class ManagedSnapshot
    with _$ManagedSnapshot
    implements Comparable<ManagedSnapshot> {
  static final _snapshotRegexp = RegExp(
    r'^(.*)_(monthly|weekly|daily)-(\d{4})-(\d{2})-(\d{2})-(\d{2})(\d{2})$',
  );

  static bool isManagedSnapshot(String snapshot) =>
      _snapshotRegexp.hasMatch(snapshot);

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
      timestamp: DateTime.utc(
        int.parse(match[3]!),
        int.parse(match[4]!),
        int.parse(match[5]!),
        int.parse(match[6]!),
        int.parse(match[7]!),
      ),
    );
  }

  DateTime get date =>
      DateTime.utc(timestamp.year, timestamp.month, timestamp.day);

  bool hasPrefix(String? prefix) => prefix == null || this.prefix == prefix;

  @override
  String toString() => '${prefix}_${label.name}-$_timestampString';

  @override
  int compareTo(ManagedSnapshot other) => compareAll([
        () => prefix.compareTo(other.prefix),
        () => label.index - other.label.index,
        () => timestamp.compareTo(other.timestamp),
      ]);

  String get _timestampString => '${timestamp.year.toString().padLeft(4, '0')}-'
      '${timestamp.month.toString().padLeft(2, '0')}-'
      '${timestamp.day.toString().padLeft(2, '0')}-'
      '${timestamp.hour.toString().padLeft(2, '0')}'
      '${timestamp.minute.toString().padLeft(2, '0')}';
}
