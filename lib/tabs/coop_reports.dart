import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_website/constants.dart';

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
	List<int> expandedIndices = [];

	Future<List<Report>> readReports(List<String> reportPaths) async {
		var reports = <Report>[];

		for (var path in reportPaths) {
			var name = path.split('/').last; // Extracting the file name
			var fileContents = await rootBundle.loadString(path);

			var report = Report(reportName: name, contents: fileContents);
			reports.add(report);
		}

		return reports;
	}

	@override
	Widget build(BuildContext context) {
		return FutureBuilder(
			future: readReports(coopTermReports),
			builder: (context, snapshot) {
				if (snapshot.connectionState == ConnectionState.waiting) {
					return const Center(child: CircularProgressIndicator());
				} else if (snapshot.hasError) {
					return Center(child: Text('Error: ${snapshot.error}'));
				
				} else if (!snapshot.hasData || snapshot.data!.isEmpty) {
					return const Center(child: Text('No reports found'));

				} else {
					return Container(
						padding: const EdgeInsets.all(10),
						child: ListView.builder(
							itemCount: snapshot.data!.length,
							itemBuilder: (context, index) {
								var report = snapshot.data![index];

								return Padding(
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
										title: Text(report.reportName),
										children: [
											SizedBox(width: MediaQuery.of(context).size.width * .6, child: Text(report.contents)),
										],
									),
								);
							},
						),
					);
				}
			},
		);
	}
}
