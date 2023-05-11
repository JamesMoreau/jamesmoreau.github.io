import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

const myName = "James Rush";
const jobTitle = "Programmer";
const myEmail = "jmorea03@uoguelph.ca";
const githubLink = 'https://github.com/JamesMoreau';
const linkedInLink = 'https://www.linkedin.com/in/james-moreau/';
const university = 'University of Guelph';
const degree = 'Honours Bachelors of Computer Science';
const markFerrariNatureGifPath = 'assets/mark_ferrari_nature.gif';
const linkedinIconPath = 'assets/linkedin.png';
const githubIconPath = 'assets/github.png';
const coopTermReportsDirectory = 'coop_term_reports/';

/* Theme data */

ThemeData lightApplicationTheme = ThemeData(
  // primarySwatch: MaterialColor(0xff6fb3b8, {}),
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
  appBarTheme: AppBarTheme(
      backgroundColor: Color(0xffe6e6e6),
      titleTextStyle: TextStyle(
          color: Color(0xff2b2b2b),
          fontWeight: FontWeight.bold,
          fontSize: 30,
          fontFamily: GoogleFonts.inconsolata().fontFamily)),
  iconTheme: const IconThemeData(),
  fontFamily: GoogleFonts.inconsolata().fontFamily,
  // textTheme: const TextTheme(
  //   displayLarge: TextStyle(fontSize: 18, color: Color(0xff2b2b2b)),
  //   displayMedium: TextStyle(fontSize: 16, color: Color(0xff2b2b2b)),
  //   displaySmall: TextStyle(fontSize: 14, color: Color(0xff2b2b2b)),
  //   headlineSmall: TextStyle(
  //       fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff2b2b2b)),
  //   headlineMedium: TextStyle(
  //       fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff2b2b2b)),
  // ),
  // tabBarTheme: const TabBarTheme(
  //   labelColor: Color(0xff2b2b2b),
  //   unselectedLabelColor: Colors.grey,
  //   labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //   // unselectedLabelStyle: TextStyle(fontSize: 14),
  // ),
  tabBarTheme: TabBarTheme(
    labelColor: const Color(0xff2b2b2b),
    unselectedLabelColor: Colors.grey,
    // labelStyle: TextStyle(
    //     fontSize: 16,
    //     fontWeight: FontWeight.bold,
    //     fontFamily: GoogleFonts.inconsolata().fontFamily),
    // unselectedLabelStyle: TextStyle(
    //     fontSize: 16,
    //     fontWeight: FontWeight.bold,
    //     fontFamily: GoogleFonts.inconsolata().fontFamily),
    indicator: const BoxDecoration(), // this make the indicator invisible
    overlayColor:
        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.hovered) ||
          states.contains(MaterialState.pressed)) return Colors.transparent;
      return Colors.red;
    }),
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
        fontFamily: GoogleFonts.inconsolata().fontFamily, color: Colors.white),
    // elevation: 0,
  ),
  // splashColor: Colors.transparent,
  // hoverColor: Colors.transparent,
  scaffoldBackgroundColor: const Color(0xffe6e6e6),
);
