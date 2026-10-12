/// Small helper utilities used for SonarCloud / CI smoke testing.
abstract final class StringUtils {
  /// Returns true when [value] is null or only whitespace.
  static bool isBlank(String? value) {
    return value == null || value.trim().isEmpty;
  }

  /// Capitalizes the first letter of [value], leaving the rest unchanged.
  static String capitalize(String value) {
    if (value.isEmpty) return value;
    return '${value[0].toUpperCase()}${value.substring(1)}';
  }

  /// Formats a rupee amount with thousand separators, e.g. `Rs. 5,000`.
  static String formatRupees(int amount) {
    final digits = amount.abs().toString();
    final buffer = StringBuffer(amount < 0 ? '-Rs. ' : 'Rs. ');
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }
}
