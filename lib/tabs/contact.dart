import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jamesmoreau_github_io/constants.dart';
import 'package:jamesmoreau_github_io/main.dart';

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
                      const SelectableText.rich(
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
                        icon: copied ? const Icon(Icons.done) : const Icon(Icons.copy),
                        onPressed: () async {
                          await Clipboard.setData(const ClipboardData(text: myEmail));
                          
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
                          text: 'Github: ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(text: githubUrl, style: const TextStyle(color: Colors.blue), recognizer: TapGestureRecognizer()..onTap = () => launchMyUrl(githubUrl)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      SvgPicture.asset(githubIconPath, width: 40, height: 40),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SelectableText.rich(
                        TextSpan(
                          text: 'LinkedIn: ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: linkedInUrl,
                              style: const TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()..onTap = () => launchMyUrl(linkedInUrl),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      SvgPicture.asset(linkedinIconPath, width: 40, height: 40),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              if (!widget.isMobileView) ...[
                const SizedBox(width: 75),
                Expanded(
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha((0.3 * 255).toInt()),
                                spreadRadius: 2,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Image.asset(fieldOfDreams, fit: BoxFit.contain),
                        ),
                        const Positioned(bottom: 0, right: 0, child: Text('juleko_o ', style: TextStyle(color: Colors.white))),
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
