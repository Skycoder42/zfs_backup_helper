import 'package:logging/logging.dart';
import 'package:riverpod/riverpod.dart';

import '../../server/commands/list_snapshots_command.dart';
import '../../server/commands/send_snapshot_command.dart';
import '../models/backup_mode.dart';
import '../models/backup_task.dart';
import '../models/config.dart';
import '../models/dataset.dart';
import '../models/managed_snapshot.dart';
import 'remote_call.dart';
import 'snapshot_parser.dart';

final backupServerAdapterProvider = Provider.family(
  (ref, Config config) => BackupServerAdapter(
    ref.watch(remoteCallProvider(config)),
    ref.watch(snapshotParserProvider),
  ),
);

class BackupServerAdapter {
  final RemoteCall _remoteCall;
  final SnapshotParser _snapshotParser;
  final _logger = Logger('$BackupServerAdapter');

  BackupServerAdapter(
    this._remoteCall,
    this._snapshotParser,
  );

  Future<List<BackupTask>> listBackupTasks(Dataset rootDataset) async {
    _logger.fine('Running listBackupTasks with root dataset: $rootDataset');
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

  Stream<List<int>> sendSnapshot(
    Dataset dataset,
    ManagedSnapshot snapshot,
    BackupMode backupMode,
  ) {
    _logger.fine(
      'Running sendSnapshot for snapshot "$dataset@$snapshot" '
      'and backup mode $backupMode',
    );
    final incrementalParent = backupMode.when(
      full: () => null,
      incremental: (parent) => parent,
    );

    return _remoteCall.runRemote(SendSnapshotCommand.commandName, {
      SendSnapshotCommand.datasetOption: dataset,
      SendSnapshotCommand.snapshotOption: snapshot,
      if (incrementalParent != null)
        SendSnapshotCommand.incrementalOption: incrementalParent,
    });
  }
}
