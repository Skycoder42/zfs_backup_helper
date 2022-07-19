import 'package:args/command_runner.dart';
import 'package:riverpod/riverpod.dart';

import 'commands/list_snapshots_command.dart';
import 'commands/send_snapshot_command.dart';

late final cliRunnerProvider = Provider(
  (ref) => CliRunner([
    ref.watch(listSnapshotsCommandProvider),
    ref.watch(sendSnapshotCommandProvider),
  ]),
);

class CliRunner extends CommandRunner<Stream<List<int>>> {
  CliRunner(List<Command<Stream<List<int>>>> commands)
      : super(
          'zfs_backup_server',
          'Application for the server to be backed up, '
              'invoked remotely by zfs_backup_client.',
        ) {
    argParser.addFlag(
      'root',
      help: 'Enables automatic root promotion. Some commands require to be run '
          'as root. With this flag enabled, those commands will attempt to '
          'automatically run themselves as root. This is done be reinvoking '
          'this program with the same arguments, but using sudo. If not set, '
          'such commands will fail instead.',
    );

    commands.forEach(addCommand);
  }
}
