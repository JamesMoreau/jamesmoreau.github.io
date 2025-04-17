import 'package:flutter/material.dart';
import 'package:jamesmoreau_github_io/main.dart';

class WorkTab extends StatelessWidget {
  const WorkTab({super.key});

  @override
  Widget build(BuildContext context) {
    var gifPath = 'assets/lost_in_translation.gif';
    var gifTitle = gifPath.split('/').last;

    return CustomScrollView(
      scrollDirection: Axis.horizontal,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: SizedBox(
                  width: 750,
                  child: ListView(
                    shrinkWrap: true,
                    children: const [
                      WorkLink(
                        text: 'Purolator Delivery Pro / Last-mile delivery service',
                        url: 'https://apps.apple.com/ca/app/purolator-delivery-pro/id1622239326',
                      ),
                      WorkLink(
                        text: 'Keyed / A simple password generator with WASM',
                        url: 'https://jamesmoreau.github.io/keyed/',
                      ),
                      WorkLink(
                        text: 'Spot Alert / A proximity based alarm app',
                        url: 'https://apps.apple.com/ca/app/spot-alert/id6478944468',
                      ),
                      WorkLink(
                        text: 'GemPaint / A WASM based paint program',
                        url: 'https://jamesmoreau.github.io/GemPaint/',
                      ),
                      WorkLink(
                        text: 'Pixel8 / Convert any image to pixel art',
                        url: 'https://jamesmoreau.github.io/pixel8/',
                      ),
                      WorkLink(
                        text: 'GemPlayer / A lightweight music player',
                        url: 'https://github.com/JamesMoreau/gem-player',
                      ),
                    ],
                  ),
                ),
              ),

              // Right: GIF (clipped first as window shrinks)
              const SizedBox(width: 75),
              Expanded(
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              spreadRadius: 2,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        width: 499,
                        height: 266,
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
          ),
        ),
      ],
    );
  }
}

class WorkLink extends StatelessWidget {
  final String text;
  final String url;

  const WorkLink({required this.text, required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          InkWell(
            onTap: () => launchMyUrl(url),
            child: HoverText(
              text: text,
              bigTextSize: 24,
              smallTextSize: 20,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.open_in_new),
        ],
      ),
    );
  }
}

class HoverText extends StatefulWidget {
  final String text;
  final double bigTextSize;
  final double smallTextSize;

  const HoverText({required this.text, required this.bigTextSize, required this.smallTextSize, super.key});

  @override
  State<HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: _isHovered ? widget.bigTextSize : widget.smallTextSize,
          ),
        ),
      ),
    );
  }
}
