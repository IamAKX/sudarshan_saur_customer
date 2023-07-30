import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateTimeFormatter {
  //2023-07-21T10:48:16.000+00:00
  static String databaseFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS";

  static String now() {
    DateTime dateTime = DateTime.now();
    return DateFormat(databaseFormat).format(dateTime);
  }

  static String timesAgo(String rawDate) {
    try {
      DateTime date = DateFormat(databaseFormat).parse(rawDate);
      return timeago.format(date, locale: 'en_short');
    } catch (e) {
      return '';
    }
  }

  static String onlyDateShort(String rawDate) {
    try {
      DateTime date = DateFormat(databaseFormat).parse(rawDate);
      return DateFormat('dd-MM-yyyy').format(date);
    } catch (e) {
      return '';
    }
  }

  static String onlyDateShortWithTime(String rawDate) {
    try {
      DateTime date = DateFormat(databaseFormat).parse(rawDate);
      return DateFormat('dd-MM-yyyy hh:mm a').format(date);
    } catch (e) {
      return '';
    }
  }

  static String onlyDateLong(String rawDate) {
    try {
      DateTime date = DateFormat(databaseFormat).parse(rawDate);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return '';
    }
  }
}
