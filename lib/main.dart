import 'package:flutter/material.dart';
import 'package:saur_customer/screens/app_intro/app_intro_screen.dart';
import 'package:saur_customer/utils/router.dart';
import 'package:saur_customer/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
Future<void> main() async{
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudarshan Saur',
      theme: globalTheme(context),
      debugShowCheckedModeBanner: false,
      home: const AppIntroScreen(),
      navigatorKey: navigatorKey,
      onGenerateRoute: NavRoute.generatedRoute,
    );
  }
}
