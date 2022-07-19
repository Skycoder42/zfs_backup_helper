import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:riverpod/riverpod.dart';
import 'package:zfs_backup_helper/src/common/process_logger.dart';
import 'package:zfs_backup_helper/src/server/cli_runner.dart';
import 'package:zfs_backup_helper/src/server/logging/server_logger.dart';

void main(List<String> args) async {
  final di = ProviderContainer(
    overrides: [
      processLoggerProvider.overrideWithProvider(serverProcessLoggerProvider),
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
  } on Exception catch (e, s) {
    di.read(serverLoggerProvider).logException(e, s);
    stderr.writeln(e);
    exitCode = 1;
  } finally {
    di.dispose();
  }
}
