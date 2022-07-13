import 'commands/list_snapshots_command.dart';

abstract class BackupApi {
  BackupApi._();

  ListSnapshotsCommand get listSnapshots;
}
