import 'package:riverpod/riverpod.dart';

import 'models/config.dart';
import 'remote/backup_server_adapter.dart';

late final clientProvider = Provider.family(
  (ref, Config config) => Client(
    ref.watch(
      backupServerAdapterProvider(config),
    ),
  ),
);

class Client {
  final BackupServerAdapter _backupServerAdapter;

  Client(this._backupServerAdapter);

  Future<void> runBackup(String rootDataset) async {
    final snapshots = await _backupServerAdapter.listSnapshots(rootDataset);

    // pass snapshots to backup controller
    // backup controller interprets + sanitizes
  }
}
