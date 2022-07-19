import 'package:test/test.dart';
import 'package:zfs_backup_helper/src/server/cli_runner.dart';

void main() {
  group('$CliRunner', () {
    late CliRunner sut;

    setUp(() {
      sut = CliRunner([]);
    });

    test('registers global parser options', () {
      final argParser = sut.argParser;

      expect(argParser.options, hasLength(2));
      expect(argParser.options, contains('help'));
      expect(argParser.options, contains('root'));
    });
  });
}
