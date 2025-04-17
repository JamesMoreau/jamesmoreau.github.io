import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jamesmoreau_github_io/main.dart';

class ContactTab extends StatefulWidget {
  final bool isMobileView;

  const ContactTab({required this.isMobileView, super.key});

  @override
  State<ContactTab> createState() => _ContactTabState();
}

const githubUrl = 'https://github.com/JamesMoreau';
const email = 'jp.moreau@aol.com';
const linkedIn = 'https://www.linkedin.com/in/james-moreau/';

class _ContactTabState extends State<ContactTab> {
  bool copied = false;

  @override
  Widget build(BuildContext context) {
    var gifPath = 'assets/field_juleko_o.gif';
    var gifTitle = gifPath.split('/').last;

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
                      const SelectableText.rich(
                        TextSpan(
                          text: email,
                          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                        ),
                      ),
                      IconButton(
                        icon: copied ? const Icon(Icons.done) : const Icon(Icons.copy),
                        onPressed: () async {
                          await Clipboard.setData(const ClipboardData(text: email));

                          copied = true;
                          setState(() {});

                          await Future<void>.delayed(const Duration(seconds: 2));
                          copied = false;
                          setState(() {});
                        },
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.email, size: 40),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SelectableText.rich(
                        TextSpan(
                          text: githubUrl,
                          style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()..onTap = () => launchMyUrl(githubUrl),
                          mouseCursor: SystemMouseCursors.click,
                        ),
                      ),
                      const SizedBox(width: 20),
                      SvgPicture.asset('assets/icons/github-mark.svg', width: 40, height: 40),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SelectableText.rich(
                        TextSpan(
                          text: linkedIn,
                          style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()..onTap = () => launchMyUrl(linkedIn),
                          mouseCursor: SystemMouseCursors.click,
                        ),
                      ),
                      const SizedBox(width: 20),
                      SvgPicture.asset('assets/icons/linkedin.svg', width: 40, height: 40),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              if (!widget.isMobileView) ...[
                const SizedBox(width: 50),
                Expanded(
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(77),
                                spreadRadius: 2,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Image.asset(gifPath, fit: BoxFit.contain),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Text(
                            gifTitle,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
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
