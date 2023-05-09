import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_website/constants.dart';
import 'package:my_website/tab_container.dart';
import 'package:my_website/windows.dart';

/*
  TODO:
    add fade in to text
    make sizes relative to screen size.
    add contact send email ui and other links
    show different ui based on which tab was clicked (could be an arrow that flashes?)
    add resume, co-op, previous work, contact/links, game.  

*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: websiteTitle,
      theme: lightApplicationTheme,
      home: const MainPage(title: websiteTitle),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController tabSelector;
  late final Animation<double> tabSelectorAnimation;

  // Color currentColor = MyColors.backgroundColor;
  // void changeColor(Color color) => setState(() => currentColor = color);
  Tab currentTab = Tab.main;

  String aboutText = '''
Hello, and welcome to my website. This site is all about myself, so if you aren't interested in me, then feel free to close this window! 
  
I use this site to showcase my work, and write about what I'm up to.''';

  final aboutThisWebsiteText = '''
This site was implemented using Flutter (a UI software development kit created by Google) and is compiled to target the web, so it is unlike a traditional JS Framework + html website.''';

  final contactText = '''email: jamespmoreau@protonmail.ca''';

  @override
  void initState() {
    super.initState();

    tabSelector = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    tabSelector.repeat(reverse: true);

    tabSelectorAnimation =
        Tween<double>(begin: -5, end: 0).animate(tabSelector);
  }

  @override
  void dispose() {
    tabSelector.dispose();
    super.dispose();
  }

  void onTabChanged(Tab tab) {
    setState(() {
      currentTab = tab;
      print('Changing tab to ' + currentTab.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.all(50),
        child: Scaffold(
            body: Container(
          decoration: BoxDecoration(
              border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          )),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(30),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(websiteTitle,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30)),
                          const SizedBox(height: 10),
                          const Text(jobTitle),
                          const SizedBox(height: 100),
                          const Text('About',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          Text(aboutText),
                          const SizedBox(height: 30),
                          const Text('This Site',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          Text(aboutThisWebsiteText),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    for (var value in Tab.values)
                                      value ==
                                              currentTab // draw the currently selected tab differently.
                                          ? Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextButton(
                                                      child: Text(value.name,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      18)),
                                                      onPressed: () =>
                                                          onTabChanged(value)),
                                                ),
                                                Center(
                                                  child: AnimatedBuilder(
                                                    animation:
                                                        tabSelectorAnimation,
                                                    builder:
                                                        (BuildContext context,
                                                            Widget? child) {
                                                      return Transform
                                                          .translate(
                                                        offset: Offset(
                                                            tabSelectorAnimation
                                                                .value,
                                                            0),
                                                        child: child,
                                                      );
                                                    },
                                                    child: const Icon(
                                                        Icons.arrow_back_ios),
                                                  ),
                                                )
                                              ],
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextButton(
                                                  child: Text(value.name,
                                                      style: const TextStyle(
                                                          fontSize: 18)),
                                                  onPressed: () =>
                                                      onTabChanged(value)),
                                            )
                                  ])
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Flexible(
                flex: 1,
                child: Container(
                    padding: const EdgeInsets.all(30),
                    alignment: Alignment.center,
                    child: getTab(currentTab)),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class MainFerrariTab extends StatelessWidget {
  const MainFerrariTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          const SizedBox(
            width: 400,
            height: 400,
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black,
                  width: 10,
                ))),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black,
                  width: 1,
                )),
                child: Image.asset('assets/mark_ferrari_nature.gif',
                    width: 300, height: 300, fit: BoxFit.cover),
              )),
        ],
      ),
    );
  }
}

Widget getTab(Tab tab) {
  switch (tab) {
    case Tab.main:
      return MainFerrariTab();
    case Tab.work:
      return Text('work');
    case Tab.contact:
      return Text('contact');
    case Tab.flutter:
      return Text('flutter');
    case Tab.game:
      return Text('game');
  }
}

enum Tab { main, work, contact, flutter, game }

class CoopTab extends StatelessWidget {
  const CoopTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10), child: const Text("Hello, Sailor!"));
  }
}

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
  splashColor: Colors.transparent,
  hoverColor: Colors.transparent,
  scaffoldBackgroundColor: const Color(0xffe6e6e6),
);
