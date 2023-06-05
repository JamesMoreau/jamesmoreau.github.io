import 'package:flutter/material.dart';

// Common colors
class MyColors {
  static const grey = Color.fromRGBO(66, 66, 66, 1);
  static Color darkGrey = const Color.fromARGB(255, 33, 33, 33);
  static const backgroundColor = Color.fromARGB(0xFF, 0xFA, 0xFF, 0xBF);
  static const white = Colors.white;
  static const black = Colors.black;
  static const blueGrey = Colors.blueGrey;
  static const transparent = Color.fromARGB(0, 0, 0, 0);
}

const myName = 'James Rush';
const jobTitle = 'Programmer';
const myEmail = 'jmorea03@uoguelph.ca';
const githubLink = 'https://github.com/JamesMoreau';
const linkedInLink = 'https://www.linkedin.com/in/james-moreau/';
const university = 'University of Guelph';
const degree = 'Honours Bachelors of Computer Science';
const markFerrariNatureGifPath = 'assets/mark_ferrari_nature.gif';
const linkedinIconPath = 'assets/linkedin.png';
const githubIconPath = 'assets/github.png';
const List<String> coopTermReports = [
  'assets/coop_term_reports/fall_2020_report.txt',
  'assets/coop_term_reports/summer_2021_report.txt',
  'assets/coop_term_reports/winter_summer_2022_report.txt'
];
const resumePngPath = 'assets/resume.png';
const lostInTranslationGifPath = 'assets/lit.gif';

/* Theme data */

ThemeData lightApplicationTheme = ThemeData(
  // primarySwatch: MaterialColor(0xff6fb3b8, {}),
  // useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff2b2b2b),
      onPrimary: Colors.white,
      secondary: Colors.yellow,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: Color(0xffe6e6e6),
      onBackground: Color(0xff2b2b2b),
      surface: Color(0xffc2edce),
      onSurface: Colors.white),
  textTheme: TextTheme(),
  appBarTheme: AppBarTheme(
      backgroundColor: Color(0xff2b2b2b),
      titleTextStyle: TextStyle(
          color: Color(0xffe6e6e6),
          fontWeight: FontWeight.bold,
          fontSize: 30,
          fontFamily: 'Inconsolata'),
          elevation: 0),
  iconTheme: const IconThemeData(),
  fontFamily: 'Inconsolata',
  tabBarTheme: TabBarTheme(
    labelColor: const Color(0xff2b2b2b),
    unselectedLabelColor: Colors.grey,
    indicator: const BoxDecoration(), // this make the indicator invisible
    overlayColor:
        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.hovered) ||
          states.contains(MaterialState.pressed)) return Colors.transparent;
      return Colors.red;
    }),
  ),
  expansionTileTheme: ExpansionTileThemeData(
    // collapsed
    collapsedBackgroundColor: const Color(0xff2b2b2b),
    collapsedTextColor: Colors.white,
    collapsedShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    collapsedIconColor: Colors.white,
    // open
    backgroundColor: Colors.transparent,
    textColor: const Color(0xff2b2b2b),
    iconColor: const Color(0xff2b2b2b),
    //other
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
  snackBarTheme: SnackBarThemeData(
    insetPadding: EdgeInsets.only(bottom: 20),
    backgroundColor: const Color(0xff2b2b2b),
    width: 300,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    contentTextStyle: TextStyle(
        fontFamily: 'Inconsolata', color: Colors.white),
    // elevation: 0,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: const Color(0xff2b2b2b),
  ),
  scaffoldBackgroundColor: const Color(0xffe6e6e6),
);
