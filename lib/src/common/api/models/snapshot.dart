import 'package:freezed_annotation/freezed_annotation.dart';

part 'snapshot.freezed.dart';
part 'snapshot.g.dart';

@freezed
class Snapshot with _$Snapshot {
  const factory Snapshot({
    required String dataset,
    required String name,
  }) = _Snapshot;

  factory Snapshot.fromJson(Map<String, dynamic> json) =>
      _$SnapshotFromJson(json);

  static List<Snapshot> fromJsonList(List<dynamic> json) => json
      .cast<Map<String, dynamic>>()
      .map((element) => Snapshot.fromJson(element))
      .toList();
}
