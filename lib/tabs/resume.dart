import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:jamesmoreau_github_io/constants.dart';
import 'package:jamesmoreau_github_io/main.dart';
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
    var raisedResumeButton = ElevatedButton.icon(onPressed: () => launchMyUrl(resumeButtonLink), icon: const Icon(Icons.open_in_new), label: Text(resumeButtonText));

    // Get the url according to the selected language
    var myUrl = switch (selectedResumeLanguage) {
      ResumeLanguage.english => resumePdfUrl,
      ResumeLanguage.french => resumePdfUrlFrench,
    };

    if (widget.isMobileView) {
      // We don't have enough space to show the actual resume so just show the button.
      return Center(child: raisedResumeButton);
    }

    // Ensure the height fits the available screen space so that the entire resume is visible.
    var availableHeight = MediaQuery.of(context).size.height;
    var pdfWidth = availableHeight / math.sqrt(2); // A4 paper ratio

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: pdfWidth,
          height: availableHeight,
          child: SfPdfViewer.network(myUrl),
        ),
        Positioned(
          right: 20,
          top: 20,
          child: Column(
            children: [
              raisedResumeButton,
              const SizedBox(height: 20),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                child: SegmentedButton<ResumeLanguage>(
                  segments: [
                    const ButtonSegment(value: ResumeLanguage.english, label: Text('English')),
                    const ButtonSegment(value: ResumeLanguage.french, label: Text('French')),
                  ],
                  selected: {selectedResumeLanguage},
                  onSelectionChanged: (language) {
                    selectedResumeLanguage = language.first;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
