import 'package:saur_customer/main.dart';

class SharedpreferenceKey {
  static const String userId = 'userId';
  static const String firstTimeAppOpen = 'firstTimeAppOpen';

  static int getUserId() {
    return prefs.getInt(userId) ?? -1;
  }
}
