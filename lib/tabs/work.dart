import 'package:flutter/material.dart';
import 'package:jamesmoreau_github_io/main.dart';

class WorkTab extends StatelessWidget {
  const WorkTab({super.key});

  @override
  Widget build(BuildContext context) {
    var gifPath = 'assets/lost_in_translation.gif'; 
    var gifTitle = gifPath.split('/').last;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView(
        children: [
          Wrap(
            children: [
              InkWell(
                child: const HoverText(text: 'Purolator Delivery Pro - Last-mile delivery service', bigTextSize: 40, smallTextSize: 25),
                onTap: () => launchMyUrl('https://apps.apple.com/ca/app/purolator-delivery-pro/id1622239326'),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.open_in_new),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            children: [
              InkWell(
                child: const HoverText(text: 'Keyed - A simple password generator with WASM', bigTextSize: 40, smallTextSize: 25),
                onTap: () => launchMyUrl('https://jamesmoreau.github.io/keyed/'),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.open_in_new),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            children: [
              InkWell(
                child: const HoverText(text: 'Spot Alert - A proximity based alarm app', bigTextSize: 40, smallTextSize: 25),
                onTap: () => launchMyUrl('https://apps.apple.com/ca/app/spot-alert/id6478944468'),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.open_in_new),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            children: [
              InkWell(
                child: const HoverText(text: 'GemPaint - A WASM based paint program', bigTextSize: 40, smallTextSize: 25),
                onTap: () => launchMyUrl('https://jamesmoreau.github.io/GemPaint/'),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.open_in_new),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            children: [
              InkWell(
                child: const HoverText(text: 'Pixel8 - Convert any image to pixel art', bigTextSize: 40, smallTextSize: 25),
                onTap: () => launchMyUrl('https://jamesmoreau.github.io/pixel8/'),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.open_in_new),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            children: [
              InkWell(
                child: const HoverText(text: 'GemPlayer - A lightweight music player', bigTextSize: 40, smallTextSize: 25),
                onTap: () => launchMyUrl('https://github.com/JamesMoreau/gem-player'),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.open_in_new),
            ],
          ),
          const SizedBox(height: 100),
          Center(
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
                  child: Image.asset(gifPath, width: 499, height: 266, fit: BoxFit.contain),
                ),
                Positioned(bottom: 0, right: 0, child: Text(gifTitle, style: const TextStyle(color: Colors.white))),
              ],
            ),
          ),
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
