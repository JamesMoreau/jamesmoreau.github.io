import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/material.dart';
import 'package:flame/camera.dart' as camera;
import 'package:flame/events.dart';
import 'package:flame/game.dart';


// THIS FILE IS NOT BEING USED.

enum GameState { initializing, ready, running, paused, won, lost }

class BrickBreaker extends Forge2DGame {
  final cameraWorld = camera.World();
  late final CameraComponent cameraComponent;

  @override
  Future<void> onLoad() async {
    // Setup camera
    cameraComponent = CameraComponent(world: cameraWorld);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, cameraWorld]);

    // Add ball
    cameraWorld.add(Ball(position: size / 2, radius: 1));

    // Add boundaries
    final topLeft = Vector2.zero();
    final bottomRight = screenToWorld(cameraComponent.viewport.size);
    final topRight = Vector2(bottomRight.x, topLeft.y);
    final bottomLeft = Vector2(topLeft.x, bottomRight.y);

    var walls = [
      Wall(topLeft, topRight),
      Wall(topRight, bottomRight),
      Wall(bottomLeft, bottomRight),
      Wall(topLeft, bottomLeft)
    ];

    cameraWorld.addAll(walls);
  }
}

class Ball extends BodyComponent {
  Vector2 position;
  double radius;
  Color color = Colors.white;

  Ball({required this.position, required this.radius});

  @override
  Body createBody() {
    final bodyDef = BodyDef(type: BodyType.dynamic, position: position);

    final ball = world.createBody(bodyDef);

    final shape = CircleShape();
    shape.radius = radius;

    final fixtureDef = FixtureDef(shape);

    ball.createFixture(fixtureDef);
    return ball;
  }

  @override
  void render(Canvas canvas) {
    var circle = body.fixtures.first.shape as CircleShape;
    var paint = Paint();
    paint.color = color;
    canvas.drawCircle(circle.position.toOffset(), radius, paint);
  }
}

class Brick extends BodyComponent {
  void foo() {}

  @override
  Body createBody() {
    var color = Colors.white;
    var shape = CircleShape();
    shape.radius = 5;

    var fixture = FixtureDef(shape, friction: 0.5);
    var bodyDef = BodyDef(position: Vector2(20, 5), type: BodyType.static);

    var body = world.createBody(bodyDef);
    body.createFixture(fixture);

    return body;
  }
}

// class Paddle extends BodyComponent {
//   Color color = Colors.white;

//   @override
//   // Body createBody() {
//   //   var shape =
//   // }

// }

class Wall extends BodyComponent {
  Vector2 start;
  Vector2 end;
  Color color = Colors.transparent;

  Wall(this.start, this.end);

  @override
  Body createBody() {
    var shape = EdgeShape();
    shape.set(start, end);
    var fixtureDef = FixtureDef(shape, friction: 0.3);
    var bodyDef = BodyDef(userData: this, position: Vector2.zero());
    var body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);

    return body;
  }

  @override
  void render(Canvas canvas) { // Empty render method so that walls are invisible.
    // final circle = body.fixtures.first.shape as CircleShape;
    // final paint = Paint();
    // paint.color = color;
    // canvas.drawLine(circle.position.toOffset(), radius, paint);
  }
}
