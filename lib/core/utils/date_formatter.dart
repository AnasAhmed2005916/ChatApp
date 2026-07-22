import 'package:intl/intl.dart';

class DateFormatter {
  static String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }
}
