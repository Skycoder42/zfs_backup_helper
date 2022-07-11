import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:riverpod/riverpod.dart';

import '../../common/api/models/snapshot.dart';
import '../../common/managed_process.dart';
import '../cli/cli_result.dart';

late final listSnapshotsCommandProvider = Provider(
  (ref) => ListSnapshotsCommand(
    ref.watch(managedProcessProvider),
  ),
);

class ListSnapshotsCommand extends Command<CliResult> {
  final ManagedProcess _managedProcess;

  ListSnapshotsCommand(this._managedProcess) {
    argParser.addOption(
      'root',
      abbr: 'r',
      valueHelp: 'dataset',
      help: 'Required. The root dataset that is queried for snapshots.',
    );
  }

  @override
  String get name => 'list-snapshots';

  @override
  String get description => '''
List all snapshots off a dataset and its children.

This command will query ZFS for the snapshots and return a JSON list containing
all snapshots of the given root dataset as well as all snapshots of all child
datasets of the root dataset. The schema is as follows:

[
  {"name": "string", "dataset": "string"}
]
''';

  @override
  bool get takesArguments => false;

  @override
  FutureOr<CliResult>? run() async {
    final root = argResults?['root'] as String?;
    if (root == null) {
      throw UsageException('The "--root" option is required.', usage);
    }

    final snapshots = _zfsListSnapshots(root).map(_parseSnapshot).toList();
    return CliResult.json(snapshots);
  }

  Stream<String> _zfsListSnapshots(String rootDataset) =>
      _managedProcess.runLines('zfs', [
        'list',
        '-H',
        '-r',
        '-o',
        'name',
        '-t',
        'snapshot',
        rootDataset,
      ]);

  Snapshot _parseSnapshot(String snapshot) {
    final elements = snapshot.split('@');
    if (elements.length != 2) {
      throw Exception(
        'Failed to parse snapshot "$snapshot" - '
        'Expected dataset and snapshot name, separated by one "@", '
        'but found ${elements.length - 1}.',
      );
    }

    return Snapshot(
      dataset: elements[0],
      name: elements[1],
    );
  }
}
