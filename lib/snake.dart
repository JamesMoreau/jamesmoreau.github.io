import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum SnakeDirection { up, down, left, right }

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
    // debugMode = true;
    main = Main();
    add(main);

    super.onLoad();
  }
}

class Main extends PositionComponent
    with KeyboardHandler, HasGameRef<SnakeGame> {
  double cellSize = 10;
  int gridSize = 10;
  int borderWidth = 2;

  bool gameOver = false;

  Position food = Position(0, 0);
  List<Position> snake = [];
  SnakeDirection direction = SnakeDirection.down;

  late Timer snakeUpdateTimer;
  double snakeUpdateInterval = 1;

  @override
  void onLoad() {
    snakeUpdateTimer = Timer(1, onTick: () => updateSnake(), repeat: true);

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
    for (var cell in snake) {
      assert(
          cell.x >= 0 && cell.x < gridSize && cell.y >= 0 && cell.y < gridSize,
          'Snake is not inside the grid.');

      var x = cell.x.toDouble() * cellSize;
      var y = cell.y.toDouble() * cellSize;
      Paint paint = Paint();
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
    print('update snaek!');
    print('current snake: ' + snake.toString());

    var snakeHead = snake.first;

    // update the snake's position
    var newHead = Position(0, 0);
    switch (direction) {
      case SnakeDirection.up:
        newHead = Position(snakeHead.x, snakeHead.y - 1);
        break;
      case SnakeDirection.down:
        newHead = Position(snakeHead.x, snakeHead.y + 1);
        break;
      case SnakeDirection.left:
        newHead = Position(snakeHead.x + 1, snakeHead.y);
        break;
      case SnakeDirection.right:
        newHead = Position(snakeHead.x - 1, snakeHead.y);
        break;
    }

    snake.insert(0, newHead);
    snake.removeLast();

    // check if snake eats food
    if (snakeHead.x == food.x && snakeHead.y == food.y) {
      snake.add(Position(food.x, food.y));
      placeNewFood();
    }
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    var isKeyDown = event is RawKeyDownEvent;
    if (!isKeyDown) return false;

    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowUp:
        direction = SnakeDirection.up;
        return true;
      case LogicalKeyboardKey.arrowRight:
        direction = SnakeDirection.right;
        return true;
      case LogicalKeyboardKey.arrowDown:
        direction = SnakeDirection.down;
        return true;
      case LogicalKeyboardKey.arrowLeft:
        direction = SnakeDirection.left;
        return true;
    }

    return false;
  }

  @override
  void update(double dt) {
    if (gameOver) {
      ///!!!
    }

    snakeUpdateTimer.update(dt);

    // for (int index = snake.length - 1; index > 0; index--) {
    //   snake[index] = snake[index - 1];
    // }

    super.update(dt);
  }
}
