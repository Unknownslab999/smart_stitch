import 'package:flutter_test/flutter_test.dart';
import 'package:smart_stitch/shared/utils/string_utils.dart';

void main() {
  group('StringUtils.isBlank', () {
    test('returns true for null', () {
      expect(StringUtils.isBlank(null), isTrue);
    });

    test('returns true for empty and whitespace', () {
      expect(StringUtils.isBlank(''), isTrue);
      expect(StringUtils.isBlank('   '), isTrue);
    });

    test('returns false for non-blank text', () {
      expect(StringUtils.isBlank('Smart Stitch'), isFalse);
    });
  });

  group('StringUtils.capitalize', () {
    test('capitalizes the first letter', () {
      expect(StringUtils.capitalize('tailor'), 'Tailor');
    });

    test('returns empty string unchanged', () {
      expect(StringUtils.capitalize(''), '');
    });
  });

  group('StringUtils.formatRupees', () {
    test('formats positive amounts', () {
      expect(StringUtils.formatRupees(500), 'Rs. 500');
      expect(StringUtils.formatRupees(5000), 'Rs. 5,000');
      expect(StringUtils.formatRupees(100000), 'Rs. 100,000');
    });
  });
}
