import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_website/constants.dart';
import 'package:my_website/main.dart';

class ContactTab extends StatelessWidget {
  final bool isMobileView;

  const ContactTab({super.key, required this.isMobileView});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SelectableText.rich(
                  TextSpan(
                    text: 'Email: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: myEmail,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: myEmail));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Copied to clipboard')),
                      );
                    }),
                SizedBox(width: 20),
                Icon(Icons.email, size: 40)
              ]),
              SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SelectableText.rich(
                  TextSpan(
                    text: 'Github: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: githubLink, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTap = () => launchMyUrl(githubLink)),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                SvgPicture.asset(githubIconPath, width: 40, height: 40)
              ]),
              SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SelectableText.rich(
                  TextSpan(
                    text: 'LinkedIn: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: linkedInLink,
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()..onTap = () => launchMyUrl(linkedInLink),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                SvgPicture.asset(linkedinIconPath, width: 40, height: 40)
              ]),
              SizedBox(height: 20),
            ],
          ),
          if (!isMobileView) ...[
            SizedBox(width: 75),
            Stack(children: [
              Container(
                  width: 500,
                  height: 600,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.black,
                    width: 2,
                  )),
                  child: Image.asset(gapOfDunloe, fit: BoxFit.cover)),
                  Positioned(bottom: 0, right: 0, child: Text('Gap of Dunloe, Ireland ', style: TextStyle(color: Colors.white)))
            ])
          ]
        ],
      ),
    );
  }
}
