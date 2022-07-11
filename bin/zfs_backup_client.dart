import 'package:riverpod/riverpod.dart';
import 'package:zfs_backup_helper/src/client/client.dart';
import 'package:zfs_backup_helper/src/client/client_cli.dart';

void main(List<String> args) async {
  final cli = ClientCli()..parse(args);

  final di = ProviderContainer();
  final client = di.read(clientProvider(cli.host));

  for (final dataset in cli.datasets) {
    await client.run(dataset);
  }
}
