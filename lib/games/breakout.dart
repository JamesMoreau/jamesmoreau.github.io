// ignore_for_file: avoid_print

import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// TODO:
// Use gameobject.new

enum GameState { ready, play, gameOver, victory }

const Size breakoutGameSize = Size(900, 600);
const Color background = Color(0xFF181818);
const degree = math.pi / 180;

const double projectileSize = 10;
const double projectileSpeed = 250;

const double paddleSpeed = 700;
const double paddleWidth = 80;
const double paddleHeight = 10;
const double paddleOffsetFromBottom = 50;
const Color paddleColor = Color(0xFFEA453C);

const double brickWidth = 50;
const double brickHeight = 10;
const double brickSpacing = 16;
const double rowsOfBricks = 8;
const double bricksPerRow = 8;

class Breakout extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents, HasGameRef<Breakout> {
  GameState state = GameState.ready;

  FpsTextComponent fps = FpsTextComponent();

  @override
  Color backgroundColor() => background;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Place walls
    await add(ScreenHitbox());

    await setup();

    if (game.debugMode) add(FpsTextComponent(position: Vector2(0, size.y), anchor: Anchor.bottomLeft));
  }

  Future<void> setup() async {
    // Clear old stuff
    removeAll(children.query<Brick>());
    removeAll(children.query<Paddle>());
    removeAll(children.query<Projectile>());

    // Place paddle
    var paddlePosition = Vector2(size.x / 2 - paddleWidth / 2, size.y - paddleOffsetFromBottom);
    var paddle = Paddle(position: paddlePosition);
    await add(paddle);

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

    var bricks = <Brick>[];
    for (var row = 0; row < rowsOfBricks; row++) {
      for (var col = 0; col < bricksPerRow; col++) {
        var color = colors[row % colors.length];
        var position = Vector2(xOffset + col * (brickWidth + brickSpacing), row * (brickHeight + brickSpacing) + yOffset);
        var brick = Brick(position: position, color: color);

        bricks.add(brick);
      }
    }

    await addAll(bricks);

    state = GameState.ready;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    var textPaint = TextPaint(style: const TextStyle(fontSize: 35, fontFamily: 'InconsolataQ', color: Colors.white));
    var centerPosition = Vector2(game.canvasSize.x / 2, game.canvasSize.y / 2);
    var topCenterPosition = Vector2(game.canvasSize.x / 2, 0);

    switch (state) {
      case GameState.ready:
        textPaint.render(canvas, 'BREAKOUT!', topCenterPosition, anchor: Anchor.topCenter);
        textPaint.render(canvas, 'Use left and right arrow keys to play.', centerPosition, anchor: Anchor.center);
      case GameState.play:
        break;
      case GameState.gameOver:
        textPaint.render(canvas, 'GAME OVER', topCenterPosition, anchor: Anchor.topCenter);
        textPaint.render(canvas, 'Press R to Restart', centerPosition, anchor: Anchor.center);
      case GameState.victory:
        textPaint.render(canvas, 'VICTORY!', topCenterPosition, anchor: Anchor.topCenter);
        textPaint.render(canvas, 'Press R to Restart', centerPosition, anchor: Anchor.center);
    }

    if (game.debugMode) {
      var textPaint = TextPaint(style: const TextStyle(fontSize: 20, fontFamily: 'Inconsolata', color: Colors.white));
      var topRightPosition = Vector2(size.x, size.y);
      var query = children.query<Paddle>();
      var projectilePosition = query.isEmpty ? Vector2.zero() : query.first.position;

      var formatter = NumberFormat('0000.00');
      var formattedX = formatter.format(projectilePosition.x);
      var formattedY = formatter.format(projectilePosition.y);

      textPaint.render(canvas, 'Projectile Position: ($formattedX, $formattedY)', topRightPosition, anchor: Anchor.bottomRight);
    }
  }
}

class Brick extends RectangleComponent with CollisionCallbacks {
  Color color;

  Brick({required super.position, required this.color}) : super(anchor: Anchor.center, size: Vector2(brickWidth, brickHeight), children: [RectangleHitbox()]);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }
}

class Paddle extends PositionComponent with KeyboardHandler, HasGameRef<Breakout> {
  int horizontalMovement = 0;

  Paddle({required super.position}) : super(size: Vector2(paddleWidth, paddleHeight), children: [RectangleHitbox()]);

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

    if (game.state != GameState.play) return;

    var movement = horizontalMovement * paddleSpeed * dt;
    position.x += movement;

    // Constrain the paddle within the game window
    if (position.x < 0) {
      position.x = 0;
    }

    if (position.x + size.x > game.size.x) {
      position.x = game.size.x - size.x;
    }
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {

    switch (game.state) {
      case GameState.ready:
        if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) || keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
          if (game.debugMode) print('starting game');
          game.state = GameState.play;

          var projectile = Projectile(position: Vector2(game.size.x / 2, game.size.y / 2));
          game.add(projectile);
        }

      case GameState.play:
        horizontalMovement = 0;
        horizontalMovement += keysPressed.contains(LogicalKeyboardKey.arrowLeft) ? -1 : 0;
        horizontalMovement += keysPressed.contains(LogicalKeyboardKey.arrowRight) ? 1 : 0;

        if (event.logicalKey == LogicalKeyboardKey.keyR) {
          game.setup();
        }
        
      case GameState.gameOver:
        if (event.logicalKey == LogicalKeyboardKey.keyR) {
          game.setup();
        }
        
      case GameState.victory:
        if (event.logicalKey == LogicalKeyboardKey.keyR) {
          game.setup();
        }

    }

    return true;
  }
}

class Projectile extends CircleComponent with CollisionCallbacks, HasGameRef<Breakout> {
  Vector2 velocity = Vector2.zero();

  Projectile({required super.position}) : super(anchor: Anchor.center, radius: projectileSize, children: [CircleHitbox()]);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    velocity = Vector2(0, projectileSpeed);
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
      } else if (intersectionPoints.first.x >= game.size.x) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y >= game.size.y) {
        // Game Over
        add(
          RemoveEffect(
            delay: 1,
            onComplete: () => game.state = GameState.gameOver,
          ),
        );
      }
    } else if (other is Paddle) {
      velocity.y = -velocity.y;
      velocity.x = velocity.x + (position.x - other.position.x) / other.size.x * game.size.x * 0.3;
    } else if (other is Brick) {
      if (position.y < other.position.y - other.size.y / 2) {
        velocity.y = -velocity.y;
      } else if (position.y > other.position.y + other.size.y / 2) {
        velocity.y = -velocity.y;
      } else if (position.x < other.position.x) {
        velocity.x = -velocity.x;
      } else if (position.x > other.position.x) {
        velocity.x = -velocity.x;
      }

      other.removeFromParent();
      var remainingBricks = game.children.query<Brick>();
      if (remainingBricks.isEmpty) {
        game.state = GameState.victory;
      }
    }
  }
}
