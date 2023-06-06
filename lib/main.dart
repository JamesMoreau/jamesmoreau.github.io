import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:my_website/constants.dart';
import 'package:my_website/snake.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flame/game.dart';

/*
  TODO:
    figure out how to host on github pages.
    add resume route with pdf.
*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightApplicationTheme,
        // home: Material(child: FPSWidget(child: const MainPage())),
        home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController tabFadeInController;
  late Animation<double> tabFadeInAnimation;

  @override
  void dispose() {
    tabFadeInController.dispose();
    super.dispose();
  }

  void onTabChanged() {
    debugPrint('Changing tab to ${currentTab.name}');
    tabFadeInController.reset();
    tabFadeInController.forward();
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
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 1000 || constraints.maxHeight < 500) {
        // Small Layout
        return Scaffold(
            appBar: AppBar(title: Text(myName)),
            drawer: Drawer(child: TabMenu(changeTab: onTabChanged)),
            body: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                color: Theme.of(context).colorScheme.primary,
              )),
              alignment: Alignment.center,
              child: FadeTransition(opacity: tabFadeInAnimation, child: Container(padding: const EdgeInsets.all(30), alignment: Alignment.center, child: getTab(currentTab))),
            ));
      }

      // Wide Layout
      return Scaffold(
          body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            )),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(flex: 1, child: TabMenu(changeTab: onTabChanged)),
                Flexible(
                  flex: 3,
                  child: FadeTransition(
                      opacity: tabFadeInAnimation,
                      child: Container(padding: const EdgeInsets.all(30), alignment: Alignment.center, child: getTab(currentTab))),
                ),
              ],
            ),
          ),
        ),
      ));
    });
  }
}

class TabMenu extends StatefulWidget {
  final void Function() changeTab; // notifies the main page that the tab has changed

  const TabMenu({super.key, required this.changeTab});

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
    return Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(30),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(myName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            const SizedBox(height: 10),
            const SelectableText(jobTitle),
            const SizedBox(height: 40),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              for (var value in Tab.values)
                value == currentTab // draw the currently selected tab differently.
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            TextButton(
                                child: Text(value.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                onPressed: () {
                                  widget.changeTab();
                                  currentTab = value;
                                }),
                            Center(
                              child: AnimatedBuilder(
                                animation: tabSelectorAnimation,
                                builder: (BuildContext context, Widget? child) {
                                  return Transform.translate(
                                    offset: Offset(tabSelectorAnimation.value, 0),
                                    child: child,
                                  );
                                },
                                child: const Icon(Icons.arrow_back_ios),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TextButton(
                            child: Text(value.name, style: const TextStyle(fontSize: 18)),
                            onPressed: () {
                              widget.changeTab();
                              currentTab = value;
                            }),
                      ),
              const SizedBox(height: 10)
            ]),
          ],
        ));
  }
}

class AboutTab extends StatelessWidget {
  final about = '''About''';
  final String aboutText = '''
Hello, and welcome to my website. This site is all about me, so if you aren't interested in me, then feel free to close this window!

I use this site to showcase my work and write about what I'm up to.

I am currently pursuing an Honours Bachelor of Computer Science at the University of Guelph.

This site was implemented using Flutter, a UI software development kit created by Google, and is compiled to target the web.''';

  const AboutTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
              SelectableText.rich(
                TextSpan(children: [
                  TextSpan(text: '$about\n\n', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: aboutText),
                ]),
              ),
            ]),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
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
                          child: Image.asset(markFerrariNatureGifPath, width: 300, height: 300, fit: BoxFit.cover),
                        )),
                    Positioned(bottom: 0, right: 0, child: Text('Mark Ferrari', style: TextStyle(color: Colors.white)))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget getTab(Tab tab) {
  return switch (tab) {
    Tab.about => AboutTab(),
    Tab.work_and_projects => WorkTab(),
    Tab.contact_and_links => ContactTab(),
    Tab.game => GameTab(),
    Tab.co_op_reports => CoopTab(),
    Tab.resume => ResumeTab()
  };
}

enum Tab { about, work_and_projects, resume, contact_and_links, co_op_reports, game }

// Globals
Tab currentTab = Tab.resume;

class Report {
  final String reportName;
  final String contents;

  const Report({required this.reportName, required this.contents});
}

class CoopTab extends StatefulWidget {
  const CoopTab({super.key});

  @override
  State<CoopTab> createState() => _CoopTabState();
}

class _CoopTabState extends State<CoopTab> {
  List<Report> reports = [];
  List<int> expandedIndices = [];

  @override
  void initState() {
    readReports(coopTermReports);
    super.initState();
  }

  Future<void> readReports(List<String> reportPaths) async {
    for (var path in reportPaths) {
      var name = basename(path);
      var fileContents = await rootBundle.loadString(path);

      reports.add(Report(reportName: name, contents: fileContents));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(10),
                  child: ExpansionTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      initiallyExpanded: expandedIndices.contains(index),
                      onExpansionChanged: (expanded) {
                        if (expanded)
                          expandedIndices.add(index);
                        else
                          expandedIndices.remove(index);
                      },
                      title: Text(reports[index].reportName),
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width * .6, child: Text(reports[index].contents)),
                      ]),
                )));
  }
}

class WorkTab extends StatelessWidget {
  const WorkTab({super.key});

  @override
  Widget build(BuildContext context) {
    var gif = Image.asset(lostInTranslationGifPath, width: 499, height: 266, fit: BoxFit.contain);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView(children: [
        Wrap(
          children: [
            InkWell(
                child: HoverText(text: 'Purolator Delivery Pro - Last Mile Delivery Service', bigTextSize: 40, smallTextSize: 25),
                onTap: () => launchMyUrl('https://apps.apple.com/ca/app/purolator-delivery-pro/id1622239326')),
            SizedBox(width: 10),
            Icon(Icons.open_in_new)
          ],
        ),
        SizedBox(height: 50),
        gif
      ]),
    );
  }
}

class HoverText extends StatefulWidget {
  final String text;
  final double bigTextSize;
  final double smallTextSize;

  const HoverText({Key? key, required this.text, required this.bigTextSize, required this.smallTextSize}) : super(key: key);

  @override
  State<HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: _isHovered ? widget.bigTextSize : widget.smallTextSize,
          ),
        ),
      ),
    );
  }
}

class ContactTab extends StatelessWidget {
  const ContactTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SelectableText.rich(
              TextSpan(
                text: 'Email: ',
                style: TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: myEmail,
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
            IconButton(
                icon: Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: myEmail));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied to clipboard')),
                  );
                }),
            SizedBox(width: 20),
            Icon(Icons.email, size: 40)
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SelectableText.rich(
              TextSpan(
                text: 'Github: ',
                style: TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: githubLink,
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()..onTap = () => launchMyUrl(githubLink)),
                ],
              ),
            ),
            SizedBox(width: 20),
            Image.asset(githubIconPath, width: 40, height: 40)
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SelectableText.rich(
              TextSpan(
                text: 'LinkedIn: ',
                style: TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: linkedInLink,
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = () => launchMyUrl(linkedInLink),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            Image.asset(linkedinIconPath, width: 40, height: 40)
          ]),
        ],
      ),
    );
  }
}

class ResumeTab extends StatefulWidget {
  const ResumeTab({super.key});

  @override
  State<ResumeTab> createState() => _ResumeTabState();
}

class _ResumeTabState extends State<ResumeTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(resumePngPath, filterQuality: FilterQuality.high),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton.icon(onPressed: () => null, icon: Icon(Icons.open_in_new), label: Text('Download')),
              ))
        ],
      ),
    );
  }

  // void showImageDialog(BuildContext context, String imagePath) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog.fullscreen(
  //           child: Stack(
  //         alignment: Alignment.center,
  //         children: [
  //           PhotoView(
  //             imageProvider: AssetImage(imagePath),
  //             filterQuality: FilterQuality.high,
  //             enableRotation: false,
  //           ),
  //           Positioned(
  //             bottom: 30,
  //             child: Padding(
  //               padding: const EdgeInsets.all(8),
  //               child: ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Close'), style: ElevatedButton.styleFrom(backgroundColor: Color(0xff2b2b2b), textStyle: TextStyle(color: Colors.white)))
  //             ),
  //           ),
  //         ],
  //       ));
  //     },
  //   );
  // }
}

Future<void> launchMyUrl(String link) async {
  var url = Uri.parse(link);
  var canLaunch = await canLaunchUrl(url);
  if (!canLaunch) {
    debugPrint('Cannot launch url');
    return;
  }

  debugPrint('launching url');
  await launchUrl(url);
}

class GameTab extends StatefulWidget {
  final double gameSize = 500;

  const GameTab({Key? key}) : super(key: key);

  @override
  State<GameTab> createState() => _GameTabState();
}

class _GameTabState extends State<GameTab> {
  FlameGame game = SnakeGame();

  @override
  void initState() {
    if (kDebugMode) game.debugMode = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: widget.gameSize,
                height: widget.gameSize,
                decoration: BoxDecoration(border: Border.all(width: 5, color: Colors.black), borderRadius: BorderRadius.all(Radius.circular(3))),
                child: GameWidget(
                  game: game,
                  loadingBuilder: (context) => Center(child: CircularProgressIndicator()),
                  errorBuilder: (context, error) => Center(child: Text("Unable to start snake game! :'(")),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ));
  }
}
