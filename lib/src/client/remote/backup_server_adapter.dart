import 'package:riverpod/riverpod.dart';

import '../../server/commands/list_snapshots_cli_command.dart';
import '../models/backup_task.dart';
import '../models/config.dart';
import 'remote_call.dart';
import 'snapshot_parser.dart';

late final backupServerAdapterProvider = Provider.family(
  (ref, Config config) => BackupServerAdapter(
    ref.watch(remoteCallProvider(config)),
    ref.watch(snapshotParserProvider),
  ),
);

class BackupServerAdapter {
  final RemoteCall _remoteCall;
  final SnapshotParser _snapshotParser;

  BackupServerAdapter(
    this._remoteCall,
    this._snapshotParser,
  );

  Future<List<BackupTask>> listSnapshots(String rootDataset) async {
    final zfsStream = _remoteCall.runRemoteLines(
      ListSnapshotsCommand.commandName,
      {
        ListSnapshotsCommand.datasetOption: rootDataset,
      },
    );

    return _snapshotParser.parseSnapshotList(
      rootDataset: rootDataset,
      snapshots: zfsStream,
    );
  }
}
