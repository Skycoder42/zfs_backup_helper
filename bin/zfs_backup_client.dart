import 'package:riverpod/riverpod.dart';
import 'package:zfs_backup_helper/src/client/client.dart';
import 'package:zfs_backup_helper/src/client/client_cli.dart';
import 'package:zfs_backup_helper/src/client/logging/client_logger.dart';
import 'package:zfs_backup_helper/src/common/logging/logger.dart';

void main(List<String> args) async {
  final cli = ClientCli()..parse(args);

  final di = ProviderContainer(
    overrides: [
      loggerProvider.overrideWithValue(ClientLogger()),
    ],
  );

  try {
    final client = di.read(clientProvider(cli.host));

    for (final dataset in cli.datasets) {
      await client.runBackup(dataset);
    }
  } finally {
    di.dispose();
  }
}
