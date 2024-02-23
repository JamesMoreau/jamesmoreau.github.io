
import 'package:flutter/material.dart';
import 'package:my_website/constants.dart';
import 'package:my_website/main.dart';

class WorkTab extends StatelessWidget {
	const WorkTab({super.key});

	@override
	Widget build(BuildContext context) {

		return Padding(
			padding: const EdgeInsets.symmetric(vertical: 20),
			child: ListView(children: [
				SizedBox(height: 100),
				Wrap(
					children: [
						InkWell(
								child: HoverText(text: 'Purolator Delivery Pro - Last-mile delivery service', bigTextSize: 40, smallTextSize: 25),
								onTap: () => launchMyUrl('https://apps.apple.com/ca/app/purolator-delivery-pro/id1622239326'),),
						SizedBox(width: 10),
						Icon(Icons.open_in_new),
					],
				),
				SizedBox(height: 20),
				Wrap(
					children: [
						InkWell(
								child: HoverText(text: 'Keyed - A simple password generator with WASM', bigTextSize: 40, smallTextSize: 25),
								onTap: () => launchMyUrl('https://jamesmoreau.github.io/keyed/'),),
						SizedBox(width: 10),
						Icon(Icons.open_in_new),
					],
				),
				SizedBox(height: 20),
				Wrap(
					children: [
						InkWell(
								child: HoverText(text: 'Location Alarm - A proximity based alarm app', bigTextSize: 40, smallTextSize: 25),
								onTap: () => launchMyUrl('https://github.com/JamesMoreau/Location-Alarm'),),
						SizedBox(width: 10),
						Icon(Icons.open_in_new),
					],
				),
				SizedBox(height: 100),
				Center(
						child: Stack(children: [
					Image.asset(lostInTranslationGifPath, width: 499, height: 266, fit: BoxFit.contain),
					Positioned(bottom: 0, right: 0, child: Text('Lost in Translation ', style: TextStyle(color: Colors.white))),
				],),),
			],),
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
