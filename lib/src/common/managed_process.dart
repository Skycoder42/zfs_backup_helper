import 'dart:io';

import 'package:riverpod/riverpod.dart';

import 'process_logger.dart';

late final managedProcessProvider = Provider(
  (ref) => ManagedProcess(
    ref.watch(processLoggerProvider),
  ),
);

class ProcessFailure implements Exception {
  final String executable;
  final List<String> arguments;
  final int exitCode;

  ProcessFailure({
    required this.executable,
    required this.arguments,
    required this.exitCode,
  });

  @override
  String toString() => '${ManagedProcess._cmdLine(executable, arguments)} '
      'failed with exit code: $exitCode';
}

class ManagedProcess {
  final ProcessLogger _logger;

  ManagedProcess(this._logger);

  Stream<List<int>> runRaw(String executable, List<String> arguments) async* {
    final process = await Process.start(executable, arguments);
    _logger.logStderr(_cmdLine(executable, arguments), process.stderr);

    yield* process.stdout;

    final exitCode = await process.exitCode;
    if (exitCode != 0) {
      throw ProcessFailure(
        executable: executable,
        arguments: arguments,
        exitCode: exitCode,
      );
    }
  }

  static String _cmdLine(String executable, List<String> arguments) =>
      '$executable ${arguments.join(' ')}';
}
