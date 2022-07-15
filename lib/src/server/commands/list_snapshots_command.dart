import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:riverpod/riverpod.dart';

import '../../common/env.dart';
import '../../common/managed_process.dart';

late final listSnapshotsCommandProvider = Provider(
  (ref) => ListSnapshotsCommand(
    ref.watch(managedProcessProvider),
  ),
);

class ListSnapshotsCommand extends Command<Stream<List<int>>> {
  static const commandName = 'list-snapshots';
  static const datasetOption = 'dataset';

  final ManagedProcess _managedProcess;

  ListSnapshotsCommand(this._managedProcess) {
    argParser.addOption(
      datasetOption,
      abbr: 'd',
      valueHelp: 'dataset',
      help: 'Required. The root dataset that is queried for snapshots.',
    );
  }

  @override
  String get name => commandName;

  @override
  String get description => '''
List all snapshots of a dataset and its children.

This command will call "zfs list" to return all snapshots of the given
<dataset>. It returns all snapshots, recursively for all child datasets. The
result is a list of snapshot names (dataset@snapshot).

Invokes zfs as: `zfs ${_zfsArgs('<dataset>').join(' ')}`
''';

  @override
  bool get takesArguments => false;

  @override
  Stream<List<int>> run() {
    final args = ArgumentError.checkNotNull(argResults, 'argResults');
    final rootDataset = args[datasetOption] as String?;
    if (rootDataset == null) {
      usageException('The "--$datasetOption" option is required.');
    }

    return _managedProcess.runRaw(zshBinary, _zfsArgs(rootDataset));
  }

  List<String> _zfsArgs(String rootDataset) => [
        'list',
        '-H',
        '-r',
        '-o',
        'name',
        '-t',
        'snapshot',
        rootDataset,
      ];
}
