import 'package:test/expect.dart';

import '../../bin/zfs_backup_client.dart' as client;
import '../../bin/zfs_backup_server.dart' as server;

void main() {
  expect(server.main, anything);
  expect(client.main, anything);
}
