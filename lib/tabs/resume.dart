
import 'package:flutter/material.dart';
import 'package:my_website/constants.dart';
import 'package:my_website/main.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ResumeTab extends StatefulWidget {
	final bool isMobileView;

	const ResumeTab({super.key, required this.isMobileView});

	@override
	State<ResumeTab> createState() => _ResumeTabState();
}

class _ResumeTabState extends State<ResumeTab> {
	@override
	Widget build(BuildContext context) {
		if (widget.isMobileView) {
			return Center(child: ElevatedButton.icon(onPressed: () => launchMyUrl(resumePdfLink), icon: Icon(Icons.open_in_new), label: Text('Link to Resume')));
		}

		return SingleChildScrollView(
			scrollDirection: Axis.horizontal,
			child: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					SizedBox(
							width: MediaQuery.of(context).size.width * 0.4,
							height: MediaQuery.of(context).size.width * 0.707,
							child: SfPdfViewer.network(resumePdfLink, initialZoomLevel: 1.1)),
					Align(
							alignment: Alignment.topLeft,
							child: Padding(
								padding: const EdgeInsets.all(10),
								child: ElevatedButton.icon(onPressed: () => launchMyUrl(resumePdfLink), icon: Icon(Icons.open_in_new), label: Text('Download')),
							))
				],
			),
		);
	}
}