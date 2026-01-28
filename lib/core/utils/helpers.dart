import 'package:intl/intl.dart';

/// Helper utility functions
class Helpers {
  Helpers._(); // Private constructor to prevent instantiation

  /// Formats date to readable string
  static String formatDate(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  /// Formats time to readable string
  static String formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  static int getDayOfWeekIndex(String dayOfWeek) {
    switch (dayOfWeek.toLowerCase()) {
      case 'monday':
        return 1;
      case 'tuesday':
        return 2;
      case 'wednesday':
        return 3;
      case 'thursday':
        return 4;
      case 'friday':
        return 5;
      case 'saturday':
        return 6;
      case 'sunday':
        return 7;
      default:
        return 0;
    }
  }

  static List<String> generateTimesSlots(String startTime, String endTime, {int interval = 30}) {
    List<String> slots = [];

    DateFormat inputFormat = DateFormat('HH:mm');
    DateFormat outputFormat = DateFormat('HH:mm a');

    DateTime start = inputFormat.parse(startTime);
    DateTime end = inputFormat.parse(endTime);

    while (start.isBefore(end)) {
      slots.add(outputFormat.format(start));
      start = start.add(Duration(minutes: interval));
    }

    return slots;
  }
}
