import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO:
// bug where changing directions really quickly can cause the snake to eat itself
// Make the snake cells look prettier.
// Add menu, instructions (arrow keys). title and short explainer.

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

    // Draw Food
    var x = food.x.toDouble() * cellSize;
    var y = food.y.toDouble() * cellSize;
    var paint = Paint();
    paint.color = Colors.green;

    Rect tileRect = Rect.fromLTRB(x, y, x + cellSize, y + cellSize);
    canvas.drawRect(tileRect, paint);

    // Draw snake
    for (int i = 0; i < snake.length; i++) {
      var cell = snake[i];

      // Don't draw a cell if it leaves the grid.
      var outOfBounds = positionIsOutOfBounds(cell);
      if (outOfBounds) continue;

      var x = cell.x.toDouble() * cellSize;
      var y = cell.y.toDouble() * cellSize;
      Paint paint = Paint();
      // paint.color = i == 0 && game.debugMode ? Colors.yellow : Colors .blue; //draw the head a different color than the rest of the body.
      paint.color = Colors.blue;
      Rect tileRect = Rect.fromLTRB(x, y, x + cellSize, y + cellSize);
      canvas.drawRect(tileRect, paint);
    }
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

    // update the snake's position
    var snakeHead = snake.first;
    var newHead = nextPosition(snakeHead, direction);
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
            if (game.debugMode) {
              if (game.paused) {
                debugPrint('Unpausing the game.');
                game.paused = false;
              } else {
                debugPrint('Resuming the game.');
                game.paused = true;
              }
            }
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
        snakeUpdateTimer = Timer(0.15, onTick: () => updateSnake(), repeat: true);

        placeNewFood();

        state = GameState.ready;
        break;

      case GameState.ready:
        debugPrint('press space to begin.');
        break;

      case GameState.play:
        assert(snake.length >= 2, 'snake should be at least two long');

        snakeUpdateTimer.update(dt); // runs the snake update code

        var head = snake.first;
        var next = nextPosition(head, direction);

        // check if snake eats food
        if (head.x == food.x && head.y == food.y) {
          snake.add(next);
          // food = Position(-1, -1);
          placeNewFood();
        }

        // check if snake is eating itself or out of bounds.
        for (int i = 1; i < snake.length; i++) {
          var body = snake[i];
          if (body.x == head.x && body.y == head.y) {
            debugPrint('snake ate itself!');
            state = GameState.gameover;
          }
        }

        var outOfBounds = positionIsOutOfBounds(head);
        if (outOfBounds) {
          debugPrint('Snake left the grid.');
          state = GameState.gameover;
        }

        break;

      case GameState.gameover:
        // display a game over text
        break;
      case GameState.victory:
        // display a victory text
        break;
    }

    super.update(dt);
  }

  Position nextPosition(Position current, Direction d) {
    return switch (direction) {
      Direction.up => Position(current.x, current.y - 1),
      Direction.down => Position(current.x, current.y + 1),
      Direction.left => Position(current.x - 1, current.y),
      Direction.right => Position(current.x + 1, current.y)
    };
  }

  bool positionIsOutOfBounds(Position p) {
    return p.x < 0 || p.y < 0 || p.x >= gridSize || p.y >= gridSize;
  }
}
