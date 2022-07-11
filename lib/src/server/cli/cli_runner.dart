import 'package:args/command_runner.dart';
import 'package:riverpod/riverpod.dart';

import '../commands/list_snapshots_command.dart';
import 'cli_result.dart';

late final cliRunnerProvider = Provider(
  (ref) => CliRunner(
    listSnapshotsCommand: ref.watch(listSnapshotsCommandProvider),
  ),
);

class CliRunner extends CommandRunner<CliResult> {
  CliRunner({
    required ListSnapshotsCommand listSnapshotsCommand,
  }) : super(
          'zfs_backup_server',
          'Application for the server to be backed up, '
              'invoked remotely by zfs_backup_client.',
        ) {
    addCommand(listSnapshotsCommand);
  }
}
