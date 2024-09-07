import 'package:flutter/material.dart';
import 'package:jamesmoreau_github_io/constants.dart';
import 'package:jamesmoreau_github_io/main.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

enum ResumeLanguage { english, french }
enum ResumeLoadingState { loading, loaded, error }

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
    var raisedResumeButton = ElevatedButton.icon(onPressed: () => launchMyUrl(resumeButtonLink), icon: const Icon(Icons.open_in_new), label: Text(resumeButtonText));

    // Get the url according to the selected language
    var myUrl = switch (selectedResumeLanguage) {
      ResumeLanguage.english => resumePdfUrl,
      ResumeLanguage.french => resumePdfUrlFrench,
    };

    if (widget.isMobileView) { // We don't have enough space to show the actual resume so just show the button.
      return Center(child: raisedResumeButton);
    }

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              width: 700,
              // width: MediaQuery.of(context).size.width * 0.4,
              // height: MediaQuery.of(context).size.height * 0.707,
              child: SfPdfViewer.network(myUrl,  ),
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
                      segments: [const ButtonSegment(value: ResumeLanguage.english, label: Text('English')), const ButtonSegment(value: ResumeLanguage.french, label: Text('French'))],
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
