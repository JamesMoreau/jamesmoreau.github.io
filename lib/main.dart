import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jamesmoreau_github_io/tabs/about.dart';
import 'package:jamesmoreau_github_io/tabs/contact_and_links.dart';
import 'package:jamesmoreau_github_io/tabs/game.dart';
import 'package:jamesmoreau_github_io/tabs/resume.dart';
import 'package:jamesmoreau_github_io/tabs/work_and_projects.dart';
import 'package:statsfl/statsfl.dart';
import 'package:url_launcher/url_launcher.dart';

/*
  TODO:
  add piano
*/

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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

const myName = 'James Moreau';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: myName, theme: lightApplicationTheme, home: const Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Tab currentTab = Tab.about;
  late AnimationController tabFadeInController;
  late Animation<double> tabFadeInAnimation;

  @override
  void dispose() {
    tabFadeInController.dispose();
    super.dispose();
  }

  void onTabChanged(Tab tab) {
    if (kDebugMode) {
      print('Changing tab to ${tab.name}');
    }
    tabFadeInController.reset();
    tabFadeInController.forward();
    currentTab = tab;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    tabFadeInController = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    tabFadeInController.forward();

    tabFadeInAnimation = CurvedAnimation(
      parent: tabFadeInController,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Too small
        if (constraints.maxWidth < 700 || constraints.maxHeight < 500) {
          return const Scaffold(body: Center(child: Text('Please resize your window to be larger.')));
        }

        // Small Layout
        if (constraints.maxWidth < 1000 || constraints.maxHeight < 600) {
          return Scaffold(
            appBar: AppBar(title: const Text(myName)),
            drawer: Drawer(child: TabMenu(changeTab: onTabChanged, currentTab: currentTab)),
            body: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              alignment: Alignment.center,
              child: FadeTransition(
                opacity: tabFadeInAnimation,
                child: Container(padding: const EdgeInsets.all(30), alignment: Alignment.center, child: getTab(currentTab, isMobileView: true)),
              ),
            ),
          );
        }

        // Wide Layout
        return Scaffold(
          body: ColoredBox(
            color: Theme.of(context).colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    TabMenu(changeTab: onTabChanged, currentTab: currentTab),
                    Expanded(
                      child: FadeTransition(
                        opacity: tabFadeInAnimation,
                        child: Container(padding: const EdgeInsets.all(16), child: getTab(currentTab, isMobileView: false)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TabMenu extends StatefulWidget {
  final Tab currentTab; // This is passed to the tab menu by the main page which holds the actual current tab.
  final void Function(Tab tab) changeTab; // notifies the main page that the tab has changed

  const TabMenu({required this.currentTab, required this.changeTab, super.key});

  @override
  State<TabMenu> createState() => _TabMenuState();
}

class _TabMenuState extends State<TabMenu> with SingleTickerProviderStateMixin {
  late final AnimationController tabSelector;
  late final Animation<double> tabSelectorAnimation;

  @override
  void initState() {
    super.initState();

    tabSelector = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    tabSelector.repeat(reverse: true);

    tabSelectorAnimation = Tween<double>(begin: -5, end: 0).animate(tabSelector);
  }

  @override
  void dispose() {
    tabSelector.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: 252,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(myName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                const SizedBox(width: 16),
                Image.asset('assets/moon.gif'),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Programmer'),
            const SizedBox(height: 40),
            for (var value in Tab.values)
              if (value == widget.currentTab) ...[
                // draw the currently selected tab differently.
                Row(
                  children: [
                    TextButton(
                      child: Text(value.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      onPressed: () {
                        widget.changeTab(value);
                        setState(() {});
                      },
                    ),
                    AnimatedBuilder(
                      animation: tabSelectorAnimation,
                      builder: (BuildContext context, Widget? child) {
                        return Transform.translate(
                          offset: Offset(tabSelectorAnimation.value, 0),
                          child: child,
                        );
                      },
                      child: const Icon(Icons.arrow_back_ios),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ] else ...[
                Row(
                  children: [
                    TextButton(
                      child: Text(value.name, style: const TextStyle(fontSize: 18)),
                      onPressed: () {
                        widget.changeTab(value);
                        setState(() {});
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            const SizedBox(height: 25),
            // Row(
            //   children: [
            //     const SizedBox(width: 20),
            //     Image.asset(moon),
            //   ],
            // ),
            if (kDebugMode) ...[
              const SizedBox(height: 25),
              StatsFl(maxFps: 300),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}

Widget getTab(Tab tab, {required bool isMobileView}) {
  return switch (tab) {
    Tab.about => const AboutTab(),
    Tab.work_and_projects => const WorkTab(),
    Tab.contact_and_links => ContactTab(isMobileView: isMobileView),
    Tab.game => const GameTab(),
    // Tab.co_op_reports     => CoopTab(),
    Tab.resume => ResumeTab(isMobileView: isMobileView),
  };
}

enum Tab {
  about,
  work_and_projects,
  resume,
  contact_and_links,
  // co_op_reports,
  game
}

Future<void> launchMyUrl(String link) async {
  var url = Uri.parse(link);
  var canLaunch = await canLaunchUrl(url);
  if (!canLaunch) {
    if (kDebugMode) print('Cannot launch url');
    return;
  }

  if (kDebugMode) print('launching url');
  await launchUrl(url);
}
