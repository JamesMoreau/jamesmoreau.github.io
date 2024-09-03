import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_website/constants.dart';
import 'package:my_website/main.dart';

class ContactTab extends StatefulWidget {
  final bool isMobileView;

  const ContactTab({required this.isMobileView, super.key});

  @override
  State<ContactTab> createState() => _ContactTabState();
}

class _ContactTabState extends State<ContactTab> {
  bool copied = false;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.horizontal,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
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
                        icon: copied ? Icon(Icons.done) : Icon(Icons.copy),
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: myEmail));
                          
                          copied = true;
                          setState(() {});

                          await Future<void>.delayed(Duration(seconds: 2));
                          copied = false;
                          setState(() {});
                        },
                      ),
                      SizedBox(width: 20),
                      Icon(Icons.email, size: 40),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SelectableText.rich(
                        TextSpan(
                          text: 'Github: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(text: githubUrl, style: TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTap = () => launchMyUrl(githubUrl)),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      SvgPicture.asset(githubIconPath, width: 40, height: 40),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SelectableText.rich(
                        TextSpan(
                          text: 'LinkedIn: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: linkedInUrl,
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()..onTap = () => launchMyUrl(linkedInUrl),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      SvgPicture.asset(linkedinIconPath, width: 40, height: 40),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
              if (!widget.isMobileView) ...[
                SizedBox(width: 75),
                Expanded(
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Image.asset(fieldOfDreams, fit: BoxFit.contain),
                        ),
                        Positioned(bottom: 0, right: 0, child: Text('juleko_o ', style: TextStyle(color: Colors.white))),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
