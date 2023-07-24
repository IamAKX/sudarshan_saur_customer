import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/screens/app_intro/app_intro_screen.dart';
import 'package:saur_customer/screens/home_container/home_container.dart';
import 'package:saur_customer/services/api_service.dart';
import 'package:saur_customer/utils/enum.dart';
import 'package:saur_customer/utils/router.dart';
import 'package:saur_customer/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'models/user_model.dart';
import 'screens/blocked_user/blocked_users_screen.dart';
import 'screens/user_onboarding/login_screen.dart';
import 'utils/preference_key.dart';

late SharedPreferences prefs;
UserModel? userModel;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  if (prefs.getInt(SharedpreferenceKey.userId) != null) {
    userModel = await ApiProvider()
        .getCustomerById(prefs.getInt(SharedpreferenceKey.userId) ?? 0);
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ApiProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Sudarshan Saur',
        theme: globalTheme(context),
        debugShowCheckedModeBanner: false,
        home: getHomeScreen(),
        navigatorKey: navigatorKey,
        onGenerateRoute: NavRoute.generatedRoute,
      ),
    );
  }

  getHomeScreen() {
    if (prefs.getBool(SharedpreferenceKey.firstTimeAppOpen) ?? true) {
      prefs.setBool(SharedpreferenceKey.firstTimeAppOpen, false);
      return const AppIntroScreen();
    } else if (userModel == null || userModel?.customerId == null) {
      return const LoginScreen();
    } else if ((userModel?.status ?? UserStatus.SUSPENDED.name) !=
        UserStatus.ACTIVE.name) {
      return const BlockedUserScreen();
    }
    return const HomeContainer();
  }
}
