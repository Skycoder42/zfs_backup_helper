import 'dart:async';

import 'package:args/args.dart';
import 'package:riverpod/riverpod.dart';

import '../../common/env.dart';
import '../../common/managed_process.dart';
import '../ffi/libc_interop.dart';
import 'executable_info.dart';
import 'root_command.dart';

late final sendSnapshotCommandProvider = Provider(
  (ref) => SendSnapshotCommand(
    ref.watch(managedProcessProvider),
    ref.watch(libcInteropProvider),
    ref.watch(executableInfoProvider),
  ),
);

class SendSnapshotCommand extends RootCommand {
  static const commandName = 'send-snapshot';
  static const datasetOption = 'dataset';
  static const snapshotOption = 'snapshot';
  static const incrementalOption = 'incremental';

  SendSnapshotCommand(
    super.managedProcess,
    super._libcInterop,
    super._executableInfo,
  ) {
    argParser
      ..addOption(
        datasetOption,
        abbr: 'd',
        valueHelp: 'dataset',
        help: 'Required. The name of the dataset to send a snapshot from.',
      )
      ..addOption(
        snapshotOption,
        abbr: 's',
        valueHelp: 'snapshot',
        help: 'Required. The name of the snapshot to send.',
      )
      ..addOption(
        incrementalOption,
        abbr: 'i',
        valueHelp: 'parent-snapshot',
        help: 'If specified, the tool will do an incremental send between '
            'the parent and the snapshot. Otherwise, a full send of the '
            'original snapshot is done.',
      );
  }

  @override
  String get name => commandName;

  @override
  String get description => '''
Send a snapshot or the difference between two snapshots as binary data.

This command will call "zfs send" for the given snapshot and dataset. By default
a full copy of the snapshot is sent. However, if "--incremental" is specified,
the difference between the two snapshots is sent instead. The send is not
recursive, which means only data of the dataset is sent, not of its children.

Non-incremental invokes zfs as: `zfs ${_zfsArgs(
        dataset: '<dataset>',
        snapshot: '<snapshot>',
        incrementalParent: null,
      ).join(' ')}`
Incremental invokes zfs as: `zfs ${_zfsArgs(
        dataset: '<dataset>',
        snapshot: '<snapshot>',
        incrementalParent: '<parent-snapshot>',
      ).join(' ')}`
''';

  @override
  bool get takesArguments => false;

  @override
  Stream<List<int>> runAsRoot() {
    final args = ArgumentError.checkNotNull(argResults, 'argResults');
    final dataset = _getRequiredArg<String>(args, datasetOption);
    final snapshot = _getRequiredArg<String>(args, snapshotOption);
    final incrementalParent = args[incrementalOption] as String?;

    return managedProcess.runRaw(
      zfsBinary,
      _zfsArgs(
        dataset: dataset,
        snapshot: snapshot,
        incrementalParent: incrementalParent,
      ),
    );
  }

  T _getRequiredArg<T extends Object>(ArgResults args, String option) {
    final value = args[option] as T?;
    if (value == null) {
      usageException('The "--$option" option is required.');
    }
    return value;
  }

  List<String> _zfsArgs({
    required String dataset,
    required String snapshot,
    required String? incrementalParent,
  }) =>
      [
        'send',
        '--verbose',
        '--raw',
        if (incrementalParent != null) ...['-i', '@$incrementalParent'],
        '$dataset@$snapshot',
      ];
}
