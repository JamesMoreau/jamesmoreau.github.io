import 'package:flutter/material.dart';

const aboutText = '''
Hello, and welcome to my website. This site is all about me, so if you aren't interested in me, then feel free to close this window! I use this site to showcase my work.

I graduated from The University of Guelph, majoring in computer science.

I have a passion for software development and am always looking for new opportunities to learn and grow. I have experience with a variety of programming languages and technologies.

I am interested in astronomy 🔭, travel 🚊, gaming 🎮, and hiking 🏔️.

This site was implemented using Flutter, a UI software development kit created by Google, and is compiled to target the web.
''';

class AboutTab extends StatelessWidget {
  const AboutTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var jamesImage = 'assets/james_eclipse.jpg';
    var jamesTitle = jamesImage.split('/').last;

    var natureImage = 'assets/mark_ferrari_nature.gif';
    var natureTitle = natureImage.split('/').last;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: aboutText),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 75),
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
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            spreadRadius: 2,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Image.asset(natureImage, width: 300, height: 300, fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(bottom: 0, right: 0, child: Text(natureTitle, style: const TextStyle(color: Colors.white))),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Stack(
                      children: [
                        Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                spreadRadius: 2,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Image.asset(jamesImage, fit: BoxFit.cover),
                        ),
                        Positioned(bottom: 0, right: 0, child: Text(jamesTitle, style: const TextStyle(color: Colors.white))),
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
