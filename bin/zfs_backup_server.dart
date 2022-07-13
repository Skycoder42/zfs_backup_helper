import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:riverpod/riverpod.dart';
import 'package:zfs_backup_helper/src/common/logging/logger.dart';
import 'package:zfs_backup_helper/src/server/cli/cli_runner.dart';
import 'package:zfs_backup_helper/src/server/logging/server_logger.dart';

void main(List<String> args) async {
  final di = ProviderContainer(
    overrides: [
      loggerProvider.overrideWithProvider(serverLoggerProvider),
    ],
  );

  try {
    final commandRunner = di.read(cliRunnerProvider);
    final result = await commandRunner.run(args);
    if (result == null) {
      return;
    }

    await result.pipe(stdout);
  } on UsageException catch (e) {
    stderr.writeln(e);
    exitCode = 127;
  } catch (e, s) {
    di.read(loggerProvider).logException(e, s);
    stderr.writeln(e);
    exitCode = 1;
  } finally {
    di.dispose();
  }
}
