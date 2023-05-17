import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_website/constants.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:photo_view/photo_view.dart';

/*
  TODO:
    add something about Lost in Translation
    add previous work, game.
    make layout work for mobile. possibly make menu drawer-like if the screen is too small?
    migrate to material3 ?
*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightApplicationTheme,
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController tabSelector;
  late final Animation<double> tabSelectorAnimation;

  Tab currentTab = Tab.resume;

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
    final Size screenSize = MediaQuery.of(context).size;
    const double minWidth = 800.0;
    const double minHeight = 500.0;

    return Container(
      color: Theme.of(context).colorScheme.background,
      constraints: BoxConstraints(minWidth: minWidth, minHeight: minHeight),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SelectableText(myName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30)),
                      const SizedBox(height: 10),
                      const SelectableText(jobTitle),
                      const SizedBox(height: 40),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var value in Tab.values)
                              value ==
                                      currentTab // draw the currently selected tab differently.
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        children: [
                                          TextButton(
                                              child: Text(value.name,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18)),
                                              onPressed: () =>
                                                  onTabChanged(value)),
                                          Center(
                                            child: AnimatedBuilder(
                                              animation: tabSelectorAnimation,
                                              builder: (BuildContext context,
                                                  Widget? child) {
                                                return Transform.translate(
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
                                          ),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8),
                                      child: TextButton(
                                          child: Text(value.name,
                                              style: const TextStyle(
                                                  fontSize: 18)),
                                          onPressed: () =>
                                              onTabChanged(value)),
                                    ),
                            const SizedBox(height: 10)
                          ]),
                    ],
                  )),
            ),
            Flexible(
              flex: 3,
              child: Container(
                  padding: const EdgeInsets.all(30),
                  alignment: Alignment.center,
                  child: getTab(currentTab)),
            ),
          ],
        ),
      )),
    );
  }
}

class AboutTab extends StatelessWidget {
  final about = '''About''';
  final String aboutText = '''
Hello, and welcome to my website. This site is all about me, so if you aren't interested in me, then feel free to close this window!

I use this site to showcase my work and write about what I'm up to.

I am currently pursuing an Honours Bachelor of Computer Science at the University of Guelph.

This site was implemented using Flutter (a UI software development kit created by Google) and is compiled to target the web.''';

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
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SelectableText.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: '$about\n\n',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: '$aboutText'),
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
                          child: Image.asset(markFerrariNatureGifPath,
                              width: 300, height: 300, fit: BoxFit.cover),
                        )),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Text('Mark Ferrari',
                            style: TextStyle(color: Colors.white)))
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
  switch (tab) {
    case Tab.about:
      return AboutTab();
    case Tab.work:
      return WorkTab();
    case Tab.contact:
      return ContactTab();
    case Tab.game:
      return Text('game');
    case Tab.co_op_reports:
      return CoopTab();
    case Tab.resume:
      return ResumeTab();
  }
}

enum Tab { about, work, resume, contact, co_op_reports, game }

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
        child: ListView(children: [
          for (int i = 0; i < reports.length; i++)
            Padding(
              padding: const EdgeInsets.all(10),
              child: ExpansionTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(reports[i].reportName),
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * .6,
                        child: Text(reports[i].contents)),
                  ]),
            )
        ]));
  }
}

class WorkTab extends StatelessWidget {
  const WorkTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('work');
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
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchMyUrl(githubLink)),
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
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => launchMyUrl(linkedInLink),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(resumePngPath, filterQuality: FilterQuality.high),
        Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () => showImageDialog(context, resumePngPath),
                icon: Icon(Icons.zoom_in)))
      ],
    );
  }

  void showImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
            child: Stack(
          alignment: Alignment.center,
          children: [
            PhotoView(
              imageProvider: AssetImage(imagePath),
              filterQuality: FilterQuality.high,
              enableRotation: false,
            ),
            Positioned(
              bottom: 30,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Close')),
              ),
            ),
          ],
        ));
      },
    );
  }
}

Future<void> launchMyUrl(String link) async {
  var url = Uri.parse(githubLink);
  var canLaunch = await canLaunchUrl(url);
  if (!canLaunch) {
    print('Cannot launch url');
    return;
  }

  print('launching url');
  await launchUrl(url);
}
