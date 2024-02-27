import 'package:flutter/material.dart';
import 'package:my_website/constants.dart';
import 'package:my_website/main.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

enum ResumeLanguage { english, french }

class ResumeTab extends StatefulWidget {
  final bool isMobileView;

  const ResumeTab({required this.isMobileView, super.key});

  @override
  State<ResumeTab> createState() => _ResumeTabState();
}

class _ResumeTabState extends State<ResumeTab> {
  ResumeLanguage selectedResumeLanguage = ResumeLanguage.english;

  @override
  Widget build(BuildContext context) {
    
    // Button that links to resume pdf repository
    var resumeButtonText = switch (selectedResumeLanguage) {
      ResumeLanguage.english => 'Link to Resume',
      ResumeLanguage.french => 'Link to French Resume',
    };
    var resumeButtonLink = switch (selectedResumeLanguage) {
      ResumeLanguage.english => resumePdfUrl,
      ResumeLanguage.french => resumePdfUrlFrench,
    };
    var raisedResumeButton = ElevatedButton.icon(onPressed: () => launchMyUrl(resumeButtonLink), icon: Icon(Icons.open_in_new), label: Text(resumeButtonText));

    // Get the url according to the selected language
    var myUrl = switch (selectedResumeLanguage) {
      ResumeLanguage.english => resumePdfUrl,
      ResumeLanguage.french => resumePdfUrlFrench,
    };


    if (widget.isMobileView) {
      return Center(child: raisedResumeButton);
    }

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.707,
              child: SfPdfViewer.network(myUrl, initialZoomLevel: 1.1 ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: raisedResumeButton,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SegmentedButton<ResumeLanguage>(
                      segments: [ButtonSegment(value: ResumeLanguage.english, label: Text('English')), ButtonSegment(value: ResumeLanguage.french, label: Text('French'))],
                      selected: {selectedResumeLanguage},
                      onSelectionChanged: (language) {
                        // By default there is only a single segment that can be selected at one time, so its value is always the first item in the selected set.
                        selectedResumeLanguage = language.first;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
