import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:jamesmoreau_github_io/main.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

const resumePdfUrl = 'https://jamesmoreau.github.io/Resume/James_Moreau.pdf';

class ResumeTab extends StatefulWidget {
  final bool isMobileView;

  const ResumeTab({required this.isMobileView, super.key});

  @override
  State<ResumeTab> createState() => _ResumeTabState();
}

class _ResumeTabState extends State<ResumeTab> {
  @override
  Widget build(BuildContext context) {
    var raisedResumeButton = ElevatedButton.icon(onPressed: () => launchMyUrl(resumePdfUrl), icon: const Icon(Icons.open_in_new), label: const Text('Link to Resume'));

    if (widget.isMobileView) {
      // We don't have enough space to show the actual resume so just show the button.
      return Center(child: raisedResumeButton);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        var availableHeight = constraints.maxHeight;
        var availableWidth = constraints.maxWidth;

        var a4AspectRatio = 1 / math.sqrt(2);

        var height = availableHeight;
        var width = height * a4AspectRatio;

        // If that width is too wide for the available space, scale down
        if (width > availableWidth) {
          width = availableWidth;
          height = width / a4AspectRatio;
        }

        return Center(
          child: SizedBox(
            width: width,
            height: height,
            child: SfPdfViewer.network(resumePdfUrl),
          ),
        );
      },
    );
  }
}

/*Positioned( // For now, we are just doing english.
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
),*/
