import 'package:flutter/material.dart';
import 'package:my_website/constants.dart';

class AboutTab extends StatelessWidget {
  String get about => '''About''';
  String get aboutText => '''
Hello, and welcome to my website. This site is all about me, so if you aren't interested in me, then feel free to close this window! I use this site to showcase my work.

I recently graduated from The University of Guelph, majoring in computer science.

This site was implemented using Flutter, a UI software development kit created by Google, and is compiled to target the web.''';

  const AboutTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '$about\n\n', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: aboutText),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 75),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 500,
                    height: 500,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                        ),
                      ),
                      child: Image.asset(markFerrariNatureGifPath, width: 300, height: 300, fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(bottom: 0, right: 0, child: Text('Mark Ferrari ', style: TextStyle(color: Colors.white))),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Stack(
                      children: [
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                            ),
                          ),
                          child: Image.asset(myFace, fit: BoxFit.cover),
                        ),
                        Positioned(bottom: 0, right: 0, child: Text('James, Eclipse ', style: TextStyle(color: Colors.white))),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
