import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jamesmoreau_github_io/games/breakout.dart';
import 'package:jamesmoreau_github_io/games/snake.dart';

enum Games { breakout, snake }

class GameTab extends StatefulWidget {
  const GameTab({super.key});

  @override
  State<GameTab> createState() => _GameTabState();
}

class _GameTabState extends State<GameTab> {
  FlameGame snakeGame = SnakeGame();
  FlameGame breakoutGame = Breakout();
  Games currentGame = Games.breakout;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentGameSize = switch (currentGame) {
      Games.snake => snakeGameSize,
      Games.breakout => breakoutGameSize,
    };

    var currentGameObject = switch (currentGame) {
      Games.snake => snakeGame,
      Games.breakout => breakoutGame,
    };

    if (kDebugMode) currentGameObject.debugMode = false;

    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                clipBehavior: Clip.hardEdge,
                width: currentGameSize.width,
                height: currentGameSize.height,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      spreadRadius: 2,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: GameWidget(
                  game: currentGameObject,
                  loadingBuilder: (context) => const Center(child: CircularProgressIndicator()),
                  errorBuilder: (context, error) => const Center(
                    child: Text(
                      "Unable to start game! :'(",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              child: SegmentedButton<Games>(
                selected: {currentGame},
                segments: [
                  const ButtonSegment(label: Text('Breakout'), value: Games.breakout),
                  const ButtonSegment(label: Text('Snake'), value: Games.snake),
                ],
                onSelectionChanged: (game) {
                  // By default there is only a single segment that can be
                  // selected at one time, so its value is always the first
                  // item in the selected set.
                  currentGame = game.first;
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
