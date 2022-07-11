import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:riverpod/riverpod.dart';
import 'package:zfs_backup_helper/src/common/logging/logger.dart';
import 'package:zfs_backup_helper/src/server/cli/cli_runner.dart';
import 'package:zfs_backup_helper/src/server/logging/server_logger.dart';

void main(List<String> args) async {
  final di = ProviderContainer(
    overrides: [
      loggerProvider.overrideWithValue(ServerLogger()),
    ],
  );

  final commandRunner = di.read(cliRunnerProvider);
  try {
    final result = await commandRunner.run(args);
    // ignore: avoid_print
    print(result);
  } on UsageException catch (e) {
    stderr
      ..writeln('Invalid arguments: ${e.message}')
      ..writeln()
      ..writeln('Usage:')
      ..writeln(e.usage);
    exitCode = 1;
  }
}
