import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_website/tabs/about.dart';
import 'package:my_website/constants.dart';
import 'package:my_website/tabs/contact.dart';
import 'package:my_website/tabs/coop_reports.dart';
import 'package:my_website/tabs/game.dart';
import 'package:my_website/tabs/resume.dart';
import 'package:my_website/tabs/work.dart';
import 'package:statsfl/statsfl.dart';
import 'package:url_launcher/url_launcher.dart';

/*
	TODO:
	Convert state to state management.
	add french / english resume
	do something with the color picker / calculator or something else cool.
	fix tab menu overflow when window is shrunk.
	fix assets/ images
	convert spaces to tabs
*/

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	const MyApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(title: myName, theme: lightApplicationTheme, home: Home());
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
		if (kDebugMode) print('Changing tab to ${currentTab.name}');
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

			// Too small
			if (constraints.maxWidth < 700 || constraints.maxHeight < 500) {
				return Scaffold(body: Center(child: Text('Please resize your window to be larger.')));
			}

			// Small Layout
			if (constraints.maxWidth < 1000 || constraints.maxHeight < 600) {
				return Scaffold(
						appBar: AppBar(title: Text(myName)),
						drawer: Drawer(child: TabMenu(changeTab: onTabChanged)),
						body: Container(
							decoration: BoxDecoration(
									border: Border.all(
								color: Theme.of(context).colorScheme.primary,
							)),
							alignment: Alignment.center,
							child: FadeTransition(
									opacity: tabFadeInAnimation,
									child: Container(padding: const EdgeInsets.all(30), alignment: Alignment.center, child: getTab(currentTab, isMobileView: true))),
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
							children: [
								TabMenu(changeTab: onTabChanged),
								Flexible(
									flex: 3,
									child: FadeTransition(
											opacity: tabFadeInAnimation,
											child: Container(padding: const EdgeInsets.all(30), alignment: Alignment.center, child: getTab(currentTab, isMobileView: false))),
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
		return Padding(
			padding: const EdgeInsets.all(20),
			child: Container(
				width: 230,
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						const Text(myName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
						const SizedBox(height: 10),
						const SelectableText(jobTitle),
						const SizedBox(height: 40),
						for (var value in Tab.values)
							if (value == currentTab) ...[
								// draw the currently selected tab differently.
								Row(
									mainAxisAlignment: MainAxisAlignment.start,
									children: [
										TextButton(
												child: Text(value.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
												onPressed: () {
													widget.changeTab();
													currentTab = value;
												}),
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
									mainAxisAlignment: MainAxisAlignment.start,
									children: [
										TextButton(
												child: Text(value.name, style: const TextStyle(fontSize: 18)),
												onPressed: () {
													widget.changeTab();
													currentTab = value;
												}),
									],
								),
								const SizedBox(height: 10),
							],
						if (kDebugMode) ...[ StatsFl(maxFps: 300), const SizedBox(height: 20), ]
					],
				),
			),
		);
	}
}

Widget getTab(Tab tab, {required bool isMobileView}) {
	return switch (tab) {
		Tab.about             => AboutTab(),
		Tab.work_and_projects => WorkTab(),
		Tab.contact_and_links => ContactTab(),
		Tab.game              => GameTab(),
		Tab.co_op_reports     => CoopTab(),
		Tab.resume            => ResumeTab(isMobileView: isMobileView),
	};
}

enum Tab { about, work_and_projects, resume, contact_and_links, co_op_reports, game }

// Globals
Tab currentTab = Tab.about;

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

