// ignore_for_file: avoid_print

// TODO:
// rm has game ref. replace with hasgamereference

import 'dart:math' as math;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

enum GameState { ready, play, gameOver, victory }

const Size breakoutGameSize = Size(900, 600);
const Color background = Color(0xFF181818);
const degree = math.pi / 180;

const double projectileSize = 10;
const double projectileSpeed = 250;
const double maxSpeed = 300;

const double paddleSpeed = 700;
const double paddleWidth = 80;
const double paddleHeight = 10;
const double paddleOffsetFromBottom = 50;
const Color paddleColor = Color(0xFFEA453C);

const double brickWidth = 60;
const double brickHeight = 14;
const double brickSpacing = 16;
const double rowsOfBricks = 8;
const double bricksPerRow = 8;

class Breakout extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents, HasGameReference<Breakout> {
  GameState state = GameState.ready;
  bool ezMode = false; // TOGGLE THIS
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
    var paddlePosition = Vector2(breakoutGameSize.width / 2 - paddleWidth / 2, breakoutGameSize.height - paddleOffsetFromBottom);
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
    var xOffset = (breakoutGameSize.width - gridWidth) / 2;
    var yOffset = 50.0;

    var bricks = <Brick>[];
    if (ezMode) {
      var brick = Brick(position: Vector2(brickWidth, breakoutGameSize.height / 2), color: colors[0]);
      bricks.add(brick);
    } else {
      for (var row = 0; row < rowsOfBricks; row++) {
        for (var col = 0; col < bricksPerRow; col++) {
          var color = colors[row % colors.length];
          var x = xOffset + col * (brickWidth + brickSpacing);
          var y = yOffset + row * (brickHeight + brickSpacing);
          var position = Vector2(x, y);
          var brick = Brick(position: position, color: color);

          bricks.add(brick);
        }
      }
    }

    await addAll(bricks);

    state = GameState.ready;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (state == GameState.play && children.query<Brick>().isEmpty) {
      state = GameState.victory;
    }
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
      var query = children.query<Projectile>();
      var projectilePosition = query.isEmpty ? Vector2.zero() : query.first.position;

      var formatter = NumberFormat('0000.00');
      var formattedX = formatter.format(projectilePosition.x);
      var formattedY = formatter.format(projectilePosition.y);

      textPaint.render(canvas, 'Projectile Position: ($formattedX, $formattedY)', topRightPosition, anchor: Anchor.bottomRight);

      var bricks = children.query<Brick>();
      var brickCount = bricks.length;
      textPaint.render(canvas, 'Brick Count: $brickCount', topRightPosition + Vector2(0, -24), anchor: Anchor.bottomRight);
    }
  }
}

class Brick extends RectangleComponent with CollisionCallbacks, HasGameReference<Breakout> {
  Color color;

  Brick({required super.position, required this.color}) : super(anchor: Anchor.topLeft, size: Vector2(brickWidth, brickHeight));

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    debugColor = Colors.transparent;

    var hitbox = RectangleHitbox();
    hitbox.debugColor = Colors.transparent;
    add(hitbox);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }

  @override
  void onRemove() {
    explode();
    super.onRemove();
  }

  void explode() {
    var brickCenter = position + size / 2;

    var particleComponent = ParticleSystemComponent(
      particle: Particle.generate(
        count: 20,
        lifespan: 0.5,
        generator: (i) => AcceleratedParticle(
          position: Vector2.zero(),
          speed: Vector2(
            (math.Random().nextDouble() - 0.5) * 400,
            (math.Random().nextDouble() - 0.5) * 400,
          ),
          child: ComputedParticle(
            renderer: (canvas, particle) {
              var currentColor = color.withOpacity(1.0 - particle.progress);
              var paint = Paint()
                ..color = currentColor
                ..style = PaintingStyle.fill;

              canvas.drawCircle(Offset.zero, 2, paint);
            },
          ),
        ),
      ),
      position: brickCenter,
    );

    game.add(particleComponent);
  }
}

class Paddle extends PositionComponent with KeyboardHandler, HasGameReference<Breakout> {
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

    if (position.x + size.x > breakoutGameSize.width) {
      position.x = breakoutGameSize.width - size.x;
    }
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    switch (game.state) {
      case GameState.ready:
        if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) || keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
          if (game.debugMode) print('starting game');
          game.state = GameState.play;

          var projectile = Projectile(position: Vector2(breakoutGameSize.width / 2, breakoutGameSize.height / 2));
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

  void emitParticlesOnProjectileImpact(Projectile projectile) {
    var collisionPoint = Vector2(projectile.position.x, position.y - size.y / 2);

    var particleComponent = ParticleSystemComponent(
      particle: Particle.generate(
        generator: (i) => AcceleratedParticle(
          position: Vector2.zero(),
          acceleration: Vector2(0, 200),
          speed: Vector2(
            (math.Random().nextDouble() - 0.5) * 150,
            -(math.Random().nextDouble() * 100 + 50),
          ),
          child: ComputedParticle(
            lifespan: 0.5,
            renderer: (canvas, particle) {
              var currentColor = Colors.white.withOpacity(1.0 - particle.progress);
              var paint = Paint()
                ..color = currentColor
                ..style = PaintingStyle.fill;

              canvas.drawCircle(
                Offset.zero,
                1.5,
                paint,
              );
            },
          ),
        ),
      ),
      position: collisionPoint,
      priority: 1,
    );

    game.add(particleComponent);
  }
}

class Projectile extends CircleComponent with CollisionCallbacks, HasGameReference<Breakout> {
  Vector2 velocity = Vector2.zero();

  Projectile({required super.position}) : super(anchor: Anchor.center, radius: projectileSize, children: [CircleHitbox()]);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    var random = math.Random();
    var minAngle = 45 * degree;
    var maxAngle = 135 * degree;
    var angle = random.nextDouble() * (maxAngle - minAngle) + minAngle;

    velocity = Vector2(
      projectileSpeed * math.cos(angle),
      projectileSpeed * math.sin(angle),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (velocity.length > maxSpeed) { // Limit the speed
      velocity = velocity.normalized() * maxSpeed;
    }

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
      var left = 0.0;
      var right = breakoutGameSize.width;
      var top = 0.0;
      var bottom = breakoutGameSize.height;
      Vector2 normal;

      
      if (position.x - radius <= left) { // Check collision with the left wall
        normal = Vector2(1, 0); // Normal pointing right
        velocity = velocity.reflected(normal);
        position.x = left + radius;

        
      } else if (position.x + radius >= right) { // Check collision with the right wall
        normal = Vector2(-1, 0); // Normal pointing left
        velocity = velocity.reflected(normal);
        position.x = right - radius;

       
      } else if (position.y - radius <= top) { // Check collision with the top wall
        normal = Vector2(0, 1); // Normal pointing down
        velocity = velocity.reflected(normal);
        position.y = top + radius;

        
      } else if (position.y + radius >= bottom) { // Check collision with the bottom wall
        // Game Over
        add(
          RemoveEffect(
            delay: 1,
            onComplete: () => game.state = GameState.gameOver,
          ),
        );
      }
    } else if (other is Paddle) {
      // Reflect the velocity
      velocity.y = -velocity.y;

      // Adjust position
      position.y = other.position.y - other.size.y / 2 - radius;

      other.emitParticlesOnProjectileImpact(this);
    } else if (other is Brick) {
      // We want to reflect based on the center of the brick.
      var brickCenterX = other.position.x + other.size.x / 2;
      var brickCenterY = other.position.y + other.size.y / 2;

      // Determine collision side
      var overlapX = (other.size.x / 2 + radius) - (position.x - brickCenterX).abs();
      var overlapY = (other.size.y / 2 + radius) - (position.y - brickCenterY).abs();

      if (overlapX < overlapY) {
        // Collision from the sides
        velocity.x = -velocity.x;
        position.x += velocity.x.sign * overlapX;
      } else {
        // Collision from top or bottom
        velocity.y = -velocity.y;
        position.y += velocity.y.sign * overlapY;
      }

      other.removeFromParent();

      var isLastBrick = game.children.query<Brick>().length == 1;
      if (isLastBrick) {
        game.state = GameState.victory;
        add(RemoveEffect()); // Projectile deletes itself.
      }
    }
  }
}
