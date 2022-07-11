import 'dart:convert';
import 'dart:io';

import 'package:riverpod/riverpod.dart';

import 'logging/logger.dart';

late final managedProcessProvider = Provider(
  (ref) => ManagedProcess(
    ref.watch(loggerProvider),
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
  String toString() =>
      '$executable ${arguments.join(' ')} failed with exit code: $exitCode';
}

class ManagedProcess {
  final Logger _logger;

  ManagedProcess(this._logger);

  Stream<List<int>> runRaw(String executable, List<String> arguments) async* {
    final process = await Process.start(executable, arguments);
    _logger.logStderr(executable, arguments, process.stderr);

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

  Stream<String> run(
    String executable,
    List<String> arguments, {
    Encoding encoding = utf8,
  }) =>
      runRaw(executable, arguments)
          .transform(encoding.decoder)
          .transform(const LineSplitter());
}
