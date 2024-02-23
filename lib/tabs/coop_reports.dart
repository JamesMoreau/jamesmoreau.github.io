import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_website/constants.dart';
import 'package:path/path.dart';

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
		super.initState();
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
											],),
								),),);
	}
}
