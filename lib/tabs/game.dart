
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_website/snake.dart';

class GameTab extends StatefulWidget {
  final double gameSize = 500;

  const GameTab({Key? key}) : super(key: key);

  @override
  State<GameTab> createState() => _GameTabState();
}

class _GameTabState extends State<GameTab> {
  FlameGame game = SnakeGame();

  @override
  void initState() {
    if (kDebugMode) game.debugMode = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: widget.gameSize,
                height: widget.gameSize,
                decoration: BoxDecoration(border: Border.all(width: 5, color: Colors.black), borderRadius: BorderRadius.all(Radius.circular(3))),
                child: GameWidget(
                  game: game,
                  loadingBuilder: (context) => Center(child: CircularProgressIndicator()),
                  errorBuilder: (context, error) => Center(child: Text("Unable to start snake game! :'(")),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ));
  }
}