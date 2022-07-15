import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:meta/meta.dart';

import '../../common/env.dart';
import '../../common/managed_process.dart';
import '../ffi/libc_interop.dart';

abstract class RootCommand extends Command<Stream<List<int>>> {
  final LibcInterop _libcInterop;

  @protected
  final ManagedProcess managedProcess;

  RootCommand(this.managedProcess, this._libcInterop);

  @override
  FutureOr<Stream<List<int>>>? run() {
    final globalArgs =
        ArgumentError.checkNotNull(globalResults, 'globalResults');

    if (isLocalDebugMode) {
      return runAsRoot();
    } else if (_libcInterop.geteuid() == 0) {
      return runAsRoot();
    } else if (globalArgs['root'] as bool) {
      return managedProcess.runRaw('sudo', _collectCommand());
    } else {
      throw Exception(
        'Command $name requires root permissions to be executed. '
        'Either start the script as root or pass "--root" for it to '
        'automatically try to get root permissions for operations that '
        'required root.',
      );
    }
  }

  @protected
  FutureOr<Stream<List<int>>>? runAsRoot();

  List<String> _collectCommand() {
    final reverseCommandChain = <String>[name];
    var command = parent;
    while (command != null) {
      reverseCommandChain.add(command.name);
      command = command.parent;
    }

    return [
      Platform.script.toFilePath(),
      ...?globalResults?.arguments,
      ...reverseCommandChain.reversed,
      ...?argResults?.arguments,
    ];
  }
}
