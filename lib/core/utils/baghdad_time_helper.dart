import 'package:timezone/timezone.dart' as tz;

/// Helper class for Baghdad timezone operations
class BaghdadTimeHelper {
  BaghdadTimeHelper._(); // Private constructor

  /// Get current time in Baghdad timezone
  static tz.TZDateTime now() {
    final baghdad = tz.getLocation('Asia/Baghdad');
    return tz.TZDateTime.now(baghdad);
  }

  /// Convert DateTime to Baghdad timezone
  static tz.TZDateTime toBaghdadTime(DateTime dateTime) {
    final baghdad = tz.getLocation('Asia/Baghdad');
    return tz.TZDateTime.from(dateTime, baghdad);
  }

  /// Get today's date (midnight) in Baghdad timezone
  static tz.TZDateTime today() {
    final now = BaghdadTimeHelper.now();
    return tz.TZDateTime(now.location, now.year, now.month, now.day);
  }

  /// Format Baghdad time to ISO8601 string
  static String toIso8601String(tz.TZDateTime dateTime) {
    return dateTime.toIso8601String();
  }

  /// Parse ISO8601 string to Baghdad time
  static tz.TZDateTime fromIso8601String(String iso8601String) {
    final dateTime = DateTime.parse(iso8601String);
    return toBaghdadTime(dateTime);
  }
}
