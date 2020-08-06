import 'package:intl/intl.dart';

class DateTimeUtil {
  static String getLastMinuteOfTheDay() {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
    return date.toString();
  }

  static String getCurrentTime() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MMMM dd yyyy h:mm a');
    String formatted = formatter.format(now);
    return formatted;
  }
}
