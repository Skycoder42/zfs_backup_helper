import 'package:test/test.dart';
import 'package:zfs_backup_helper/src/client/util/combine_comparable.dart';

void main() {
  group('compareAll', () {
    test('returns first non 0 result', () {
      final result = compareAll([
        () => 0,
        () => 0,
        () => 5,
        () => 0,
        () => -5,
      ]);

      expect(result, 5);
    });

    test('returns 0 if all are 0', () {
      final result = compareAll([
        () => 0,
        () => 0,
        () => 0,
      ]);

      expect(result, 0);
    });
  });
}
