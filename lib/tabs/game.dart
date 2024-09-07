import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jamesmoreau_github_io/snake.dart';

class GameTab extends StatefulWidget {
  double get gameSize => 500;

  const GameTab({super.key});

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
              decoration: BoxDecoration(border: Border.all(width: 5, color: const Color(0xff7f7fff)), borderRadius: const BorderRadius.all(Radius.circular(3))),
              child: GameWidget(
                game: game,
                loadingBuilder: (context) => const Center(child: CircularProgressIndicator()),
                errorBuilder: (context, error) => const Center(child: Text("Unable to start snake game! :'(")),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
