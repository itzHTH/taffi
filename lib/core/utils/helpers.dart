/// Helper utility functions
class Helpers {
  Helpers._(); // Private constructor to prevent instantiation

  /// Formats date to readable string
  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  /// Formats time to readable string
  static String formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
