import 'package:args/command_runner.dart';
import 'package:riverpod/riverpod.dart';

import '../../common/api/api.dart';
import '../commands/list_snapshots_cli_command.dart';
import 'cli_result.dart';

late final cliRunnerProvider = Provider(
  (ref) => CliRunner(
    listSnapshots: ref.watch(listSnapshotsCliCommandProvider),
  ),
);

class CliRunner extends CommandRunner<CliResult> implements BackupApi {
  CliRunner({
    required this.listSnapshots,
  }) : super(
          'zfs_backup_server',
          'Application for the server to be backed up, '
              'invoked remotely by zfs_backup_client.',
        ) {
    addCommand(listSnapshots);
  }

  @override
  ListSnapshotsCliCommand listSnapshots;
}
