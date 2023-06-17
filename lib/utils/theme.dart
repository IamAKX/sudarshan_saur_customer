import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

const double defaultPadding = 20;
const double bottomNavigationBarBorderRadius = 40;
const double homePageUserIconSize = 40;
const double familyIcon = 40;
const double settingsPageUserIconSize = 90;

ThemeData globalTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: false,
    scaffoldBackgroundColor: background,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      background: background, // Your accent color
    ),
    dividerColor: dividerColor,
    secondaryHeaderColor: Colors.grey[700],
    primaryColor: primaryColor,
    canvasColor: background,
    cardColor: background,
    textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme).apply(
      bodyColor: textColorDark,
      displayColor: textColorLight,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: textColorDark),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      alignLabelWithHint: false,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultPadding * 3),
        borderSide: const BorderSide(
          color: primaryColor,
          width: 1,
          // style: BorderStyle.none,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultPadding * 3),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
    ),
  );
}

InputDecoration secondaryTextFieldDecoration(String hint) {
  return InputDecoration(
    alignLabelWithHint: false,
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(defaultPadding / 2),
      borderSide: const BorderSide(
        color: primaryColor,
        width: 1,
      ),
    ),
    hintText: hint,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(defaultPadding / 2),
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
  );
}
