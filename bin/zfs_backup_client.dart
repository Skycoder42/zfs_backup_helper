import 'package:riverpod/riverpod.dart';
import 'package:zfs_backup_helper/src/client/client.dart';
import 'package:zfs_backup_helper/src/client/client_cli.dart';
import 'package:zfs_backup_helper/src/client/logging/client_logger.dart';
import 'package:zfs_backup_helper/src/common/logging/logger.dart';

void main(List<String> args) async {
  final di = ProviderContainer(
    overrides: [
      loggerProvider.overrideWithValue(ClientLogger()),
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
