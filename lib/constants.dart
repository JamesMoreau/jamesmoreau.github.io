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

const myName = 'James Moreau';
const jobTitle = 'Programmer';
const myEmail = 'jp.moreau@aol.com';
const githubUrl = 'https://github.com/JamesMoreau';
const linkedInUrl = 'https://www.linkedin.com/in/james-moreau/';
const university = 'University of Guelph';
const degree = 'Honours Bachelors of Computer Science';
const myFace = 'assets/james_eclipse.jpg';
const markFerrariNatureGifPath = 'assets/mark_ferrari_nature.gif';
const linkedinIconPath = 'assets/icons/linkedin.svg';
const githubIconPath = 'assets/icons/github-mark.svg';
const List<String> coopTermReports = [
  'assets/coop_term_reports/fall_2020_report.txt',
  'assets/coop_term_reports/summer_2021_report.txt',
  'assets/coop_term_reports/winter_summer_2022_report.txt',
];
const reportsDirectoryPath = 'assets/coop_term_reports/';
const resumePdfUrl = 'https://jamesmoreau.github.io/Resume/JamesMoreau.pdf';
const resumePdfUrlFrench = 'https://jamesmoreau.github.io/Resume/JacquesMoreauFR.pdf';
const lostInTranslationGifPath = 'assets/lit.gif';
const gapOfDunloe = 'assets/gap_of_dunloe.jpeg';
const fieldOfDreams = 'assets/field_juleko_o.gif';

/* Theme data */

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
