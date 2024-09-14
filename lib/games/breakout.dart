// ignore_for_file: avoid_print

import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// TODO:
// Make fps text decide to display based on debug mode immediately (in the render method)

enum GameState { ready, play, gameOver, victory }

const Size breakoutGameSize = Size(900, 600);
const Color background = Color(0xFF181818);
const degree = math.pi / 180;

const double projectileSize = 20;
const double projectileSpeed = 300;

const double paddleSpeed = 700;
const double paddleWidth = 80;
const double paddleHeight = 10;
const double paddleOffsetFromBottom = 50;
const Color paddleColor = Color(0xFFEA453C);

const double brickWidth = 50;
const double brickHeight = 10;
const double brickSpacing = 16;
const double rowsOfBricks = 9;
const double bricksPerRow = 10;

class Breakout extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents, HasGameRef<Breakout> {
  GameState state = GameState.play;
  List<Brick> bricks = [];
  Paddle? paddle;
  Projectile? projectile;

  @override
  Color backgroundColor() => background;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Place walls
    await add(ScreenHitbox());

    // Place paddle
    paddle = Paddle()
      ..size.setValues(paddleWidth, paddleHeight)
      ..position = Vector2(size.x / 2 - paddleWidth / 2, size.y - paddleOffsetFromBottom);

    await add(paddle!);

    // Place bricks
    var colors = [
      const Color(0xFFE9443A),
      const Color(0xFFD88B42),
      const Color(0xFFC3B549),
      const Color(0xFFAAD44F),
      const Color(0xFF8DEF55),
      const Color(0xFF76EF78),
      const Color(0xFF69D3A2),
      const Color(0xFF5AB2C3),
      const Color(0xFF4885DE),
    ];

    var gridWidth = brickWidth * bricksPerRow + brickSpacing * (bricksPerRow - 1);
    var xOffset = (size.x - gridWidth) / 2;
    var yOffset = 50.0;

    for (var row = 0; row < rowsOfBricks; row++) {
      for (var col = 0; col < bricksPerRow; col++) {
        var color = colors[row % colors.length];

        var brick = Brick(color: color)
          ..size.setValues(brickWidth, brickHeight)
          ..position = Vector2(xOffset + col * (brickWidth + brickSpacing), row * (brickHeight + brickSpacing) + yOffset);

        bricks.add(brick);
      }
    }

    await addAll(bricks);

    // Place projectile
    projectile = Projectile()
      ..size.setValues(projectileSize, projectileSize)
      ..position = Vector2(size.x / 2, size.y / 2);

    await add(projectile!);

    if (gameRef.debugMode) {
      add(FpsTextComponent(position: Vector2(0, size.y - 24)));
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    switch (state) {
      case GameState.ready:
        break;
      case GameState.play:
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

    if (gameRef.debugMode) {
      var textPaint = TextPaint(style: const TextStyle(fontSize: 20, fontFamily: 'Inconsolata', color: Colors.white));
      var topRightPosition = Vector2(size.x, size.y);
      var projectilePosition = projectile == null ? Vector2.zero() : projectile!.position;

      var formatter = NumberFormat('0000.00');
      var formattedX = formatter.format(projectilePosition.x);
      var formattedY = formatter.format(projectilePosition.y);

      textPaint.render(canvas, 'Projectile Position: ($formattedX, $formattedY)', topRightPosition, anchor: Anchor.bottomRight);
    }
  }
}

class Brick extends PositionComponent with CollisionCallbacks {
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

class Paddle extends PositionComponent with KeyboardHandler, HasGameRef<Breakout> {
  int horizontalMovement = 0;

  Paddle() : super(anchor: Anchor.center, children: [RectangleHitbox()]);

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

    var movement = horizontalMovement * paddleSpeed * dt;
    position.x += movement;

    // Constrain the paddle within the game window
    if (position.x < 0) {
      position.x = 0;
    }

    if (position.x + size.x > gameRef.size.x) {
      position.x = gameRef.size.x - size.x;
    }
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalMovement = 0;

    horizontalMovement += keysPressed.contains(LogicalKeyboardKey.arrowLeft) ? -1 : 0;
    horizontalMovement += keysPressed.contains(LogicalKeyboardKey.arrowRight) ? 1 : 0;

    return true;
  }
}

class Projectile extends CircleComponent with CollisionCallbacks, HasGameRef<Breakout> {
  Vector2 velocity = Vector2.zero();

  Projectile() : super(anchor: Anchor.center, radius: projectileSize, children: [CircleHitbox()]);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    var random = math.Random().nextDouble();
    var spawnAngle = lerpDouble(0, 360, random)!;

    var vx = math.cos(spawnAngle * degree) * projectileSpeed;
    var vy = math.sin(spawnAngle * degree) * projectileSpeed;

    velocity = Vector2(vx, vy);
    // velocity = Vector2(0, -projectileSpeed);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += velocity * dt;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (game.debugMode) {
      var now = DateTime.now();
      var hour = now.hour.toString().padLeft(2, '0');
      var minute = now.minute.toString().padLeft(2, '0');
      var second = now.second.toString().padLeft(2, '0');
      print('Projectile collided with $other. [$hour:$minute:$second]');
    }

    if (other is ScreenHitbox) {
      if (intersectionPoints.first.y <= 0) {
        velocity.y = -velocity.y;
      } else if (intersectionPoints.first.x <= 0) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.x >= gameRef.size.x) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y >= gameRef.size.y) {
        velocity.y = -velocity.y;
      }

    } else if (other is Paddle) {
      velocity.y = -velocity.y;
      velocity.x = velocity.x + (position.x - other.position.x) / other.size.x * gameRef.size.x * 0.3;

    } else if (other is Brick) {

      
    }

  }
}

// if (other is ScreenHitbox) {
//   final collisionPoint = intersectionPoints.first;

//   if (collisionPoint.x == 0) { // Left Side Collision
//     velocity.x = -velocity.x;
//     velocity.y = velocity.y;
//   }

//   if (collisionPoint.x == game.size.x) { // Right Side Collision
//     velocity.x = -velocity.x;
//     velocity.y = velocity.y;
//   }

//   if (collisionPoint.y == 0) { // Top Side Collision
//     velocity.x = velocity.x;
//     velocity.y = -velocity.y;
//   }

//   if (collisionPoint.y == game.size.y) { // Bottom Side Collision
//     velocity.x = velocity.x;
//     velocity.y = -velocity.y;
//   }
// }