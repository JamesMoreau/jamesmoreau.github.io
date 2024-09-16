import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum GameState { setup, ready, play, gameover, victory }

enum Direction { up, down, left, right }

Size snakeGameSize = const Size(500, 500);
int gridSize = 16;
double snakeUpdateInterval = 0.15;

class SnakeGame extends FlameGame with HasKeyboardHandlerComponents {
  late Main main;

  @override
  void onLoad() {
    main = Main();
    add(main);

    super.onLoad();
  }
}

class Main extends PositionComponent with KeyboardHandler, HasGameRef<SnakeGame> {
  GameState state = GameState.setup;

  Vector2 food = Vector2(0, 0);
  List<Vector2> snake = [];
  Direction direction = Direction.down;
  bool changedDirectionThisTurn = false;
  bool hasEatenFood = false;

  late Timer snakeUpdateTimer;

  @override
  void render(Canvas canvas) {
    var cellSize = gameRef.canvasSize.x / gridSize;
    var epsilon = 0.1;

    // Draw Food
    var x = food.x * cellSize;
    var y = food.y * cellSize;
    var paint = Paint();
    paint.color = const Color.fromARGB(255, 76, 206, 137);

    // Rect tileRect = Rect.fromLTRB(x, y, x + cellSize, y + cellSize);
    var r = RRect.fromLTRBR(x, y, x + cellSize, y + cellSize, const Radius.circular(2));
    canvas.drawRRect(r, paint);

    // Draw snake
    for (var i = 0; i < snake.length; i++) {
      var cell = snake[i];

      // Don't draw a cell if it leaves the grid.
      var outOfBounds = positionIsOutOfBounds(cell);
      if (outOfBounds) continue;

      var x = cell.x * cellSize;
      var y = cell.y * cellSize;
      var paint = Paint();
      // paint.color = i == 0 && game.debugMode ? Colors.yellow : Colors .blue; //draw the head a different color than the rest of the body.
      paint.color = const Color(0xff7f7fff);

      // Epsilon is a small amount that is subtracted from the cell size so that multiple cells do not overlap and keeps them from z fighting.
      var r = RRect.fromLTRBR(x, y, x + cellSize - epsilon, y + cellSize - epsilon, const Radius.circular(2));
      canvas.drawRRect(r, paint);
    }

    // Draw UI.
    var textPaint = TextPaint(style: const TextStyle(fontSize: 35, fontFamily: 'Inconsolata', color: Colors.white));
    var centerPosition = Vector2(gameRef.canvasSize.x / 2, gameRef.canvasSize.y / 2);
    var bottomCenterPosition = Vector2(gameRef.canvasSize.x / 2, gameRef.canvasSize.y);
    var topCenterPosition = Vector2(gameRef.canvasSize.x / 2, 0);

    if (state == GameState.victory) {
      textPaint.render(canvas, 'You Win!', centerPosition, anchor: Anchor.center);
      textPaint.render(canvas, "Press 'R' to restart", bottomCenterPosition, anchor: Anchor.bottomCenter);
    } else if (state == GameState.gameover) {
      textPaint.render(canvas, 'Game Over.', centerPosition, anchor: Anchor.center);
      textPaint.render(canvas, "Press 'R' to restart", bottomCenterPosition, anchor: Anchor.bottomCenter);
    } else if (state == GameState.ready) {
      textPaint.render(canvas, 'SNAKE GAME', topCenterPosition, anchor: Anchor.topCenter);
      textPaint.render(canvas, "Press 'Space' to start.", bottomCenterPosition, anchor: Anchor.bottomCenter);
      textPaint.render(canvas, 'Use arrow keys to play.', centerPosition, anchor: Anchor.center);
    }
  }

  void placeNewFood() {
    // Check if there are no places to place the food. This is the victory condition, ie, the snake occupies the entire grid.
    if (snake.length == gridSize * gridSize) { //game is won
      state = GameState.victory;
      return;
    }

    while (true) {
      var random = math.Random();
      food.x = random.nextInt(gridSize).toDouble();
      food.y = random.nextInt(gridSize).toDouble();

      // check food is not in the same position as the snake.
      var inSnake = false;
      for (var position in snake) {
        if (food.x == position.x && food.y == position.y) inSnake = true;
      }
      if (!inSnake) break;
    }
  }

  void updateSnake() {
    if (kDebugMode) print('current snake: $snake, length: ${snake.length}, direction: ${direction.name}.');

    // update the snake's position
    var newHead = nextPosition(snake.first, direction);
    snake.insert(0, newHead);

    if (!hasEatenFood) {
      snake.removeLast();
    } else {
      hasEatenFood = false; // Reset the flag.
    }
    changedDirectionThisTurn = false;
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is! KeyDownEvent) return false; // we only care about key down events.

    // we have different keyboard behaviours depending on the current game's state.
    switch (state) {
      case GameState.setup:
        // We don't take any input during setup phase.
        return false;

      case GameState.ready:
        switch (event.logicalKey) {
          case LogicalKeyboardKey.space:
            state = GameState.play;
            game.paused = false;
            return true;
        }
        return false;

      case GameState.play:
        switch (event.logicalKey) {
          case LogicalKeyboardKey.arrowUp:
            if (direction != Direction.down && !changedDirectionThisTurn) {
              changeSnakeDirection(Direction.up);
              return true;
            }
          case LogicalKeyboardKey.arrowRight:
            if (direction != Direction.left && !changedDirectionThisTurn) {
              changeSnakeDirection(Direction.right);
              return true;
            }
          case LogicalKeyboardKey.arrowDown:
            if (direction != Direction.up && !changedDirectionThisTurn) {
              changeSnakeDirection(Direction.down);
              return true;
            }
          case LogicalKeyboardKey.arrowLeft:
            if (direction != Direction.right && !changedDirectionThisTurn) {
              changeSnakeDirection(Direction.left);
              changedDirectionThisTurn = true;
              return true;
            }
          case LogicalKeyboardKey.keyR:
            if (kDebugMode) print('restarting game');
            state = GameState.setup;
            return true;
          case LogicalKeyboardKey.space:
            if (game.debugMode) {
              if (game.paused) {
                if (kDebugMode) print('Unpausing the game.');
                game.paused = false;
              } else {
                if (kDebugMode) print('Resuming the game.');
                game.paused = true;
              }
              return true;
            }
            return false;

          case LogicalKeyboardKey.keyV:
            if (game.debugMode) {
              state = GameState.victory;
              if (kDebugMode) print('Setting Victory.');
              return true;
            }
            return false;
        }
        return false;

      case GameState.gameover:
        switch (event.logicalKey) {
          case LogicalKeyboardKey.keyR:
            if (kDebugMode) print('Restarting Game.');
            state = GameState.setup;
            return true;
        }
        return false;

      case GameState.victory:
        switch (event.logicalKey) {
          case LogicalKeyboardKey.keyR:
            if (kDebugMode) print('Restarting Game.');
            state = GameState.setup;
            return true;
        }
        return false;
    }
  }

  void changeSnakeDirection(Direction newDirection) {
    if (changedDirectionThisTurn) return;
    if ((direction == Direction.up && newDirection == Direction.down) ||
        (direction == Direction.down && newDirection == Direction.up) ||
        (direction == Direction.left && newDirection == Direction.right) ||
        (direction == Direction.right && newDirection == Direction.left)) {
      return; // Prevent reversing direction.
    }
    direction = newDirection;
    changedDirectionThisTurn = true;
  }

  @override
  void update(double dt) {
    switch (state) {
      case GameState.setup:

        // set snake's initial position
        snake = [Vector2(0, 2), Vector2(0, 1)];
        direction = Direction.down;
        snakeUpdateTimer = Timer(snakeUpdateInterval, onTick: updateSnake, repeat: true);

        placeNewFood();

        state = GameState.ready;

      case GameState.ready:
        // if (kDebugMode) print('press space to begin.');
        break;

      case GameState.play:
        assert(snake.length >= 2, 'snake should be at least two long');

        snakeUpdateTimer.update(dt); // runs the snake update code

        var head = snake.first;
        // var next = nextPosition(head, direction);

        // check if snake eats food
        if (head.x == food.x && head.y == food.y) {
          hasEatenFood = true;
          // snake.add(next);
          placeNewFood();
        }

        // check if snake is eating itself.
        for (var i = 1; i < snake.length; i++) {
          var body = snake[i];
          if (body.x == head.x && body.y == head.y) {
            if (kDebugMode) print('snake ate itself!');
            state = GameState.gameover;
          }
        }

        // Check if snake is out of bounds
        var outOfBounds = positionIsOutOfBounds(head);
        if (outOfBounds) {
          if (kDebugMode) print('Snake left the grid.');
          state = GameState.gameover;
        }

      case GameState.gameover:
        // display a game over text
        break;
      case GameState.victory:
        // display a victory text
        break;
    }

    super.update(dt);
  }

  Vector2 nextPosition(Vector2 current, Direction d) {
    return switch (direction) {
      Direction.up => Vector2(current.x, current.y - 1),
      Direction.down => Vector2(current.x, current.y + 1),
      Direction.left => Vector2(current.x - 1, current.y),
      Direction.right => Vector2(current.x + 1, current.y)
    };
  }

  bool positionIsOutOfBounds(Vector2 p) {
    return p.x < 0 || p.y < 0 || p.x >= gridSize || p.y >= gridSize;
  }
}
