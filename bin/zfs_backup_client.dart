import 'dart:io';

import 'package:logging/logging.dart';
import 'package:riverpod/riverpod.dart';
import 'package:zfs_backup_helper/src/client/client.dart';
import 'package:zfs_backup_helper/src/client/client_cli.dart';
import 'package:zfs_backup_helper/src/client/logging/client_logger.dart';
import 'package:zfs_backup_helper/src/common/process_logger.dart';

void main(List<String> args) async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(stdout.writeln);

  final di = ProviderContainer(
    overrides: [
      processLoggerProvider.overrideWithProvider(clientProcessLoggerProvider),
    ],
  );

  try {
    final cli = di.read(clientCliProvider(args));
    final client = di.read(clientProvider(cli.config));

    for (final dataset in cli.datasets) {
      await client.runBackup(dataset);
    }
  } finally {
    di.dispose();
  }
}
