import 'package:intl/intl.dart';

class DateTimeFormatter {
  //2023-07-21T10:48:16.000+00:00
  static String databaseFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS";

  static String now() {
    DateTime dateTime = DateTime.now();
    return DateFormat(databaseFormat).format(dateTime);
  }
}
