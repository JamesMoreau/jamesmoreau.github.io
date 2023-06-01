import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum GameState { start, play, gameover, victory}

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

class Main extends PositionComponent
    with KeyboardHandler, HasGameRef<SnakeGame> {
  double cellSize = 10;
  int gridSize = 30;
  int borderWidth = 2;

  bool gameOver = false;

  Position food = Position(0, 0);
  List<Position> snake = [];
  Direction direction = Direction.down;

  late Timer snakeUpdateTimer;
  double snakeUpdateInterval = 1;

  @override
  void onLoad() {
    snakeUpdateTimer = Timer(0.1, onTick: () => updateSnake(), repeat: true);

    snake = [
      Position(0, 3),
      Position(0, 2),
      Position(0, 1),
    ]; // set snake's initial position

    placeNewFood();
  }

  @override
  void render(Canvas canvas) {
    cellSize = gameRef.canvasSize.x / gridSize;

    // Draw snake
    for (int i = 0; i < snake.length; i++) {
      var cell = snake[i];
      assert(
          cell.x >= 0 && cell.x < gridSize && cell.y >= 0 && cell.y < gridSize,
          'Snake is not inside the grid.');

      var x = cell.x.toDouble() * cellSize;
      var y = cell.y.toDouble() * cellSize;
      Paint paint = Paint();
      paint.color = i == 0 ? Colors.yellow : Colors.blue; //draw the head a different color than the rest of the body.
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
        newHead = Position(snakeHead.x + 1, snakeHead.y);
        break;
      case Direction.right:
        newHead = Position(snakeHead.x - 1, snakeHead.y);
        break;
    }

    snake.insert(0, newHead);
    snake.removeLast();
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    var isKeyDown = event is RawKeyDownEvent;
    if (!isKeyDown) return false;

    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowUp:
        if (direction != Direction.up) direction = Direction.up;
        return true;
      case LogicalKeyboardKey.arrowRight:
        if (direction != Direction.right) direction = Direction.right;
        return true;
      case LogicalKeyboardKey.arrowDown:
        if (direction != Direction.down) direction = Direction.down;
        return true;
      case LogicalKeyboardKey.arrowLeft:
        if (direction != Direction.left) direction = Direction.left;
        return true;
      case LogicalKeyboardKey.keyR:
        debugPrint('restarting game');
        return true;
      case LogicalKeyboardKey.space:
        if (game.debugMode) game.paused = !game.paused;
    }

    return false;
  }

  @override
  void update(double dt) {
    if (gameOver) {
      ///!!!
    }

    snakeUpdateTimer.update(dt);

    // check if snake eats food
    var snakeHead = snake.first;
    if (snakeHead.x == food.x && snakeHead.y == food.y) {
      snake.add(Position(food.x, food.y));
      placeNewFood();
    }

    // for (int index = snake.length - 1; index > 0; index--) {
    //   snake[index] = snake[index - 1];
    // }

    super.update(dt);
  }
}
