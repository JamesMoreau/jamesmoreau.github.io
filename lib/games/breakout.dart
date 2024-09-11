import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum GameState { start, ready, play, pause, gameOver, victory }

const Size breakoutGameSize = Size(1000, 600);
const Color background = Color(0xFF181818);

const double projectileSize = 20;
const double projectileSpeed = 400;
const Color projectileColor = Colors.white;

const double paddleSpeed = 700;
const double paddleWidth = 80;
const double paddleHeight = 20;
const double paddleOffsetFromBottom = 50;
const Color paddleColor = Colors.white;

const double brickWidth = 80;
const double brickHeight = 20;
const double brickSpacing = 20;
const double rowsOfBricks = 8;
const double bricksPerRow = 8;

class Breakout extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents {
  GameState state = GameState.play;

  @override
  Color backgroundColor() => background;

  @override
  Future<void> onLoad() async {
    super.onLoad(); 
    
    size.setValues(breakoutGameSize.width, breakoutGameSize.height);

    var paddle = Paddle()
      ..size.setValues(paddleWidth, paddleHeight)
      ..position = Vector2(breakoutGameSize.width / 2 - paddleWidth / 2, breakoutGameSize.height - paddleOffsetFromBottom);

    add(paddle);

    placeBricks();
  }

  void placeBricks() {
    var bricks = <Brick>[];
    var colors = [const Color(0xFFE9443A), const Color(0xFFD88B42), const Color(0xFFC3B549), const Color(0xFFAAD44F), const Color(0xFF8DEF55), const Color(0xFF76EF78), const Color(0xFF69D3A2), const Color(0xFF5AB2C3), const Color(0xFF4885DE)];

    var gridWidth = brickWidth * bricksPerRow + brickSpacing * (bricksPerRow - 1);
    var xOffset = (breakoutGameSize.width - gridWidth) / 2;
    var yOffset = 50.0;

    for (var row = 0; row < rowsOfBricks; row++) {
      for (var col = 0; col < bricksPerRow; col++) {

        var color = colors[row % colors.length];

        var brick = Brick(color: color)
          ..size.setValues(brickWidth, brickHeight)
          ..position = Vector2(xOffset + col * (brickWidth + brickSpacing), row * (brickHeight + brickSpacing) + yOffset);

        add(brick);
      }
    }

    addAll(bricks);
  }

  @override
  void update(double dt) {
    super.update(dt);

    switch (state) {
      case GameState.start:
        break;
      case GameState.ready:
        break;
      case GameState.play:
        break;
      case GameState.pause:
        break;
      case GameState.gameOver:
        break;
      case GameState.victory:
        break;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

  }
}

class Brick extends PositionComponent {
  Color color;

  Brick({required this.color});

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    var paint = Paint();
    paint.color = color;
    canvas.drawRect(size.toRect(), paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}

class Paddle extends PositionComponent with KeyboardHandler, CollisionCallbacks, HasGameRef<Breakout> {
  @override
  void render(Canvas canvas) {
    super.render(canvas);

    var paint = Paint();
    paint.color = paddleColor;
    canvas.drawRect(size.toRect(), paint);

  }

  @override
  void update(double dt) {
    super.update(dt);

    switch (gameRef.state) {
      case GameState.start:
        break;
      case GameState.ready:
        break;
      case GameState.play:
        break;
      case GameState.pause:
        break;
      case GameState.gameOver:
        break;
      case GameState.victory:
        break;
    }
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is! KeyDownEvent) return false;

    switch (gameRef.state) {
      case GameState.start:
        break;
      case GameState.ready:
        break;
      case GameState.play:
        if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          position.x -= paddleSpeed * 1;
        } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
          position.x += paddleSpeed;
        }
      case GameState.pause:
        break;
      case GameState.gameOver:
        break;
      case GameState.victory:
        break;
    }

    return false;
  }

}
