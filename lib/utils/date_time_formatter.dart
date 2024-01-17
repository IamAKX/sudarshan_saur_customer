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

  static String guaranteeCardDate(String rawDate) {
    try {
      DateTime date = DateFormat(databaseFormat).parse(rawDate);
      return DateFormat('dd/MM/yyyy').format(date);
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

  static String formatDatePicker(DateTime rawDate) {
    try {
      return DateFormat('dd/MM/yyyy').format(rawDate);
    } catch (e) {
      return '';
    }
  }

  static DateTime toDateTime(String date) {
    try {
      return DateFormat('dd/MM/yyyy').parse(date);
    } catch (e) {
      return DateTime.now();
    }
  }

  static bool isValidInstallationDate(String date1, String date2) {
    DateTime d1 = toDateTime(date1);
    DateTime d2 = toDateTime(date2);
    return d1.isBefore(d2) || d1.isAtSameMomentAs(d2);
  }
}
