import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/snapshot.dart';
import 'command.dart';

part 'list_snapshots_command.freezed.dart';

@freezed
class ListSnapshotRequest with _$ListSnapshotRequest {
  const factory ListSnapshotRequest({required String rootDataset}) =
      _ListSnapshotRequest;
}

abstract class ListSnapshotsCommand
    implements Command<List<Snapshot>, ListSnapshotRequest> {
  ListSnapshotsCommand._();
}
