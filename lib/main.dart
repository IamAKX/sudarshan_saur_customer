import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saur_customer/screens/app_intro/app_intro_screen.dart';
import 'package:saur_customer/screens/home_container/home_container.dart';
import 'package:saur_customer/screens/raise_warranty_request/conclusion_screen.dart';
import 'package:saur_customer/screens/raise_warranty_request/installation_address_screen.dart';
import 'package:saur_customer/screens/user_onboarding/register_screen.dart';
import 'package:saur_customer/services/api_service.dart';
import 'package:saur_customer/utils/date_time_formatter.dart';
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
  if (prefs.getString(SharedpreferenceKey.userPhone) != null) {
    log('User found in cache, fething user details');
    userModel = await ApiProvider().getUserByPhoneSilent(
        prefs.getString(SharedpreferenceKey.userPhone) ?? "");
    if (userModel != null) {
      log('User fetch, updating last login');
      await ApiProvider().updateUser(
          {'lastLogin': DateTimeFormatter.now()}, userModel?.customerId ?? 0);
    }
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
      return const RegisterScreen();
    } else if ((userModel!.status) == UserStatus.CREATED.name &&
        prefs.containsKey(SharedpreferenceKey.ongoingRequest)) {
      return const InstallationAddressScreen();
    } else if ((userModel!.status) == UserStatus.PENDING.name ||
        (userModel!.status) == UserStatus.CREATED.name) {
      return ConclusionScreen(
        name: userModel?.customerName ?? 'User',
      );
    } else if ((userModel!.status) == UserStatus.SUSPENDED.name) {
      return const BlockedUserScreen();
    }
    return const HomeContainer();
  }
}
