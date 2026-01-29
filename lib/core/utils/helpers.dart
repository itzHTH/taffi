import 'package:intl/intl.dart';
import 'package:taffi/core/utils/baghdad_time_helper.dart';

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

    DateTime start = inputFormat.parse(startTime);
    DateTime end = inputFormat.parse(endTime);

    while (start.isBefore(end)) {
      slots.add(inputFormat.format(start));
      start = start.add(Duration(minutes: interval));
    }

    return slots;
  }

  /// Converts time from "HH:mm a" format (e.g., "02:30 PM") to "HH:mm:ss" format for API
  /// Example: "02:30 PM" -> "14:30:00"
  static String formatTimeOfDay(String timeString) {
    return "$timeString:00.000";
  }

  static bool isDateTimeBeforeNow(String date, String time) {
    DateTime inputDate = DateTime.parse(date);
    DateTime inputTime = DateFormat('HH:mm').parse(time);
    DateTime inputDateTime = DateTime(
      inputDate.year,
      inputDate.month,
      inputDate.day,
      inputTime.hour,
      inputTime.minute,
    );
    return inputDateTime.isBefore(BaghdadTimeHelper.now());
  }
}
