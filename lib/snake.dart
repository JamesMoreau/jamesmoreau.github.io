import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum GameState { setup, ready, play, gameover, victory }

enum Direction { up, down, left, right }

class Position {
  int x = 0;
  int y = 0;

  Position(this.x, this.y);

  @override
  String toString() {
    return '{x: $x, y: $y}';
  }
}

class SnakeGame extends FlameGame with HasKeyboardHandlerComponents {
  late Main main;

  @override
  void onLoad() {
    debugMode = true;
    main = Main();
    add(main);

    super.onLoad();
  }
}

class Main extends PositionComponent with KeyboardHandler, HasGameRef<SnakeGame> {
  GameState state = GameState.setup;
  double cellSize = 10;
  int gridSize = 20;

  Position food = Position(0, 0);
  List<Position> snake = [];
  Direction direction = Direction.down;

  late Timer snakeUpdateTimer;
  double snakeUpdateInterval = 1;

  @override
  void onLoad() {}

  @override
  void render(Canvas canvas) {
    cellSize = gameRef.canvasSize.x / gridSize;

    // Draw snake
    for (int i = 0; i < snake.length; i++) {
      var cell = snake[i];

      var x = cell.x.toDouble() * cellSize;
      var y = cell.y.toDouble() * cellSize;
      Paint paint = Paint();
      // paint.color = i == 0 && game.debugMode ? Colors.yellow : Colors .blue; //draw the head a different color than the rest of the body.
      paint.color = Colors.blue;
      Rect tileRect = Rect.fromLTRB(x, y, x + cellSize, y + cellSize);
      canvas.drawRect(tileRect, paint);
    }

    // Draw Food
    var x = food.x.toDouble() * cellSize;
    var y = food.y.toDouble() * cellSize;
    var paint = Paint();
    paint.color = Colors.green;

    Rect tileRect = Rect.fromLTRB(x, y, x + cellSize, y + cellSize);
    canvas.drawRect(tileRect, paint);
  }

  void placeNewFood() {
    while (true) {
      var random = math.Random();
      food.x = random.nextInt(gridSize);
      food.y = random.nextInt(gridSize);

      // check food is not in the same position as the snake.
      var notInSnake = false;
      for (var position in snake) {
        if (food.x != position.x && food.y != position.y) notInSnake = true;
      }
      if (notInSnake) break;
    }
  }

  void updateSnake() {
    debugPrint('current snake: $snake, length: ${snake.length}, direction: ${direction.name}.');

    var snakeHead = snake.first;

    // update the snake's position
    var newHead = Position(0, 0);
    switch (direction) {
      case Direction.up:
        newHead = Position(snakeHead.x, snakeHead.y - 1);
        break;
      case Direction.down:
        newHead = Position(snakeHead.x, snakeHead.y + 1);
        break;
      case Direction.left:
        newHead = Position(snakeHead.x - 1, snakeHead.y);
        break;
      case Direction.right:
        newHead = Position(snakeHead.x + 1, snakeHead.y);
        break;
    }

    snake.insert(0, newHead);
    snake.removeLast();
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    var isKeyDown = event is RawKeyDownEvent;
    if (!isKeyDown) return false;

    // we have different keyboard behaviours depending on the current game's state.
    switch (state) {
      case GameState.setup:
        // We don't take any input during setup phase.
        return false;

      case GameState.ready:
        switch (event.logicalKey) {
          case LogicalKeyboardKey.space:
            state = GameState.play;
            return true;
        }
        return false;

      case GameState.play:
        switch (event.logicalKey) {
          case LogicalKeyboardKey.arrowUp:
            if (direction != Direction.down) direction = Direction.up;
            return true;
          case LogicalKeyboardKey.arrowRight:
            if (direction != Direction.left) direction = Direction.right;
            return true;
          case LogicalKeyboardKey.arrowDown:
            if (direction != Direction.up) direction = Direction.down;
            return true;
          case LogicalKeyboardKey.arrowLeft:
            if (direction != Direction.right) direction = Direction.left;
            return true;
          case LogicalKeyboardKey.keyR:
            debugPrint('restarting game');
            state = GameState.setup;
            return true;
          case LogicalKeyboardKey.space:
            if (game.debugMode) game.paused = !game.paused;
            return true;
        }
        return false;

      case GameState.gameover:
        switch (event.logicalKey) {
          case LogicalKeyboardKey.keyR:
            debugPrint('Restarting Game.');
            state = GameState.setup;
            return true;
        }
        return false;

      case GameState.victory:
        return false;
    }
  }

  @override
  void update(double dt) {
    switch (state) {
      case GameState.setup:

        // set snake's initial position
        snake = [Position(0, 2), Position(0, 1)];
        direction = Direction.down;
        snakeUpdateTimer = Timer(0.1, onTick: () => updateSnake(), repeat: true);

        placeNewFood();

        state = GameState.ready;

      case GameState.ready:
        debugPrint('press space to begin.');

      case GameState.play:
        assert(snake.length >= 2, 'snake should be at least two long');

        snakeUpdateTimer.update(dt);

        // check if snake eats food
        var snakeHead = snake.first;
        if (snakeHead.x == food.x && snakeHead.y == food.y) {
          snake.add(Position(food.x, food.y));
          placeNewFood();
        }

        // check if snake is eating itself or out of bounds.
        var head = snake.first;

        for (int i = 1; i < snake.length; i++) {
          var body = snake[i];
          if (body.x == head.x && body.y == head.y) {
            debugPrint('snake ate itself!');
            state = GameState.gameover;
          }
        }

        if (head.x < 0 || head.y < 0 || head.x >= gridSize || head.y >= gridSize) {
          debugPrint('Snake left the grid.');
          state = GameState.gameover;
        }

      case GameState.gameover:
      // display a game over text
      case GameState.victory:
      // display a victory text
    }

    super.update(dt);
  }
}
