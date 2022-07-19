import 'dart:io';

import 'package:test/test.dart';

void main() {
  group('zfs_backup_server', () {
    Future<ProcessResult> _runSut(List<String> arguments) => Process.run(
          'dart',
          [
            '-DFAKE_ZFS_BIN=tool/fake-zfs.sh',
            'bin/zfs_backup_server.dart',
            ...arguments
          ],
        );

    test('prints help if no options are specified', () async {
      final result = await _runSut(const []);

      expect(result.exitCode, 0);
      expect(
        result.stdout,
        startsWith('Application for the server to be backed up,'),
      );
      expect(result.stderr, isEmpty);
    });
  });
}
