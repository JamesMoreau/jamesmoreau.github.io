import 'package:flutter/material.dart';

class MyColors {
  static const grey = Color.fromRGBO(66, 66, 66, 1);
  static Color darkGrey = const Color.fromARGB(255, 33, 33, 33);
  static const backgroundColor = Color.fromARGB(0xFF, 0xFA, 0xFF, 0xBF);
  static const white = Colors.white;
  static const black = Colors.black;
  static const blueGrey = Colors.blueGrey;
  static const transparent = Color.fromARGB(0, 0, 0, 0);
}

ThemeData lightApplicationTheme = ThemeData(
  // primarySwatch: MaterialColor(0xff6fb3b8, {}),
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff2b2b2b),
    onPrimary: Colors.white,
    secondary: Color(0xff2b2b2b),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Color(0xffe6e6e6),
    onSurface: Color(0xff2b2b2b),
  ),
  fontFamily: 'Inconsolata',
  textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Color(0xff2b2b2b),
    titleTextStyle: TextStyle(color: Color(0xffe6e6e6), fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Inconsolata'),
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2b2b2b), foregroundColor: Colors.white, padding: const EdgeInsets.all(15)),
  ),
  expansionTileTheme: ExpansionTileThemeData(
    // collapsed
    collapsedBackgroundColor: const Color(0xff2b2b2b),
    collapsedTextColor: Colors.white,
    collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    collapsedIconColor: Colors.white,
    // open
    backgroundColor: Colors.transparent,
    textColor: const Color(0xff2b2b2b),
    iconColor: const Color(0xff2b2b2b),
    //other
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  snackBarTheme: const SnackBarThemeData(
    insetPadding: EdgeInsets.only(bottom: 20),
    backgroundColor: Color(0xff2b2b2b),
    width: 300,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    contentTextStyle: TextStyle(fontFamily: 'Inconsolata', color: Colors.white),
  ),
);
