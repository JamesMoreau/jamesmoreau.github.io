import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO: 
// move walls outside of game window
// add ball
// Collosion of walls and balls

enum GameState { ready, play, gameOver, victory }

const Size breakoutGameSize = Size(900, 600);
const Color background = Color(0xFF181818);
const double wallThickness = 10;

const double projectileSize = 10;
const double projectileSpeed = 400;

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

class Breakout extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents {
  GameState state = GameState.play;

  @override
  Color backgroundColor() => background;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    size.setValues(breakoutGameSize.width, breakoutGameSize.height);

    // Place walls
    var wallTop = Wall(position: Vector2.zero(), size: Vector2(breakoutGameSize.width, wallThickness));
    var wallBottom = Wall(position: Vector2(0, breakoutGameSize.height - wallThickness), size: Vector2(breakoutGameSize.width, wallThickness));
    var wallLeft = Wall(position: Vector2.zero(), size: Vector2(wallThickness, breakoutGameSize.height));
    var wallRight = Wall(position: Vector2(breakoutGameSize.width - wallThickness, 0), size: Vector2(wallThickness, breakoutGameSize.height));

    await addAll([wallTop, wallBottom, wallLeft, wallRight]);

    // Place paddle
    var paddle = Paddle()
      ..size.setValues(paddleWidth, paddleHeight)
      ..position = Vector2(breakoutGameSize.width / 2 - paddleWidth / 2, breakoutGameSize.height - paddleOffsetFromBottom);

    add(paddle);

    // Place bricks
    var bricks = <Brick>[];
    var colors = [
      const Color(0xFFE9443A),
      const Color(0xFFD88B42),
      const Color(0xFFC3B549),
      const Color(0xFFAAD44F),
      const Color(0xFF8DEF55),
      const Color(0xFF76EF78),
      const Color(0xFF69D3A2),
      const Color(0xFF5AB2C3),
      const Color(0xFF4885DE)
    ];

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

    await addAll(bricks);

    // Place projectile
    var projectile = Projectile()
      ..size.setValues(projectileSize, projectileSize)
      ..position = Vector2(breakoutGameSize.width / 2, breakoutGameSize.height / 2);

    add(projectile);
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
  }
}

class Brick extends PositionComponent with CollisionCallbacks{
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
  int horizontalMovement = 0;

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

    switch (gameRef.state) {
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
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalMovement = 0;

    horizontalMovement += keysPressed.contains(LogicalKeyboardKey.arrowLeft) ? -1 : 0;
    horizontalMovement += keysPressed.contains(LogicalKeyboardKey.arrowRight) ? 1 : 0;

    return true;
  }
}

class Wall extends PositionComponent with CollisionCallbacks {
  Wall({required Vector2 position, required Vector2 size}) {
    this.position = position;
    this.size = size;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    anchor = Anchor.topLeft;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    var paint = Paint();
    paint.color = Colors.blue;
    canvas.drawRect(size.toRect(), paint);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    throw UnimplementedError();
    
  }
}

class Projectile extends PositionComponent with CollisionCallbacks {
  Vector2 velocity = Vector2.zero();

  @override
  Future<void> onLoad() async {
    velocity = Vector2(0, projectileSpeed);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    var paint = Paint();
    paint.color = Colors.white;
    canvas.drawRect(size.toRect(), paint);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += velocity * dt;
  }
  
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    
    if (other is Wall) {
      velocity.y *= -1;
    }

    if (other is Brick) {
      remove(other);
      velocity.y *= -1;
    }

    if (other is Paddle) {
      velocity.y *= -1;
    }
    
  }
}
