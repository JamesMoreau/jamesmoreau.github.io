import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/material.dart';
import 'package:flame/camera.dart' as camera;
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class BrickBreaker extends Forge2DGame {
  final cameraWorld = camera.World();
  late final CameraComponent cameraComponent;

  @override
  void onLoad() {
    // debugMode = true;

    // cameraComponent = CameraComponent(world: cameraWorld);
    // cameraComponent.viewfinder.anchor = Anchor.topLeft;
    // addAll([cameraComponent, cameraWorld]);

    // var main = Main();
    // add(main);

    super.onLoad();

    overlays.add('PreGame');
  }
}

class Main extends PositionComponent
    with KeyboardHandler, HasGameRef<BrickBreaker> {
  List<Brick> bricks = [];
  late Paddle paddle;
  int numberOfBricksWidth = 10;
  int numberOfBricksHeight = 4;

  @override
  void onLoad() async {
    super.onLoad();

    final ballPosition = Vector2(size.x / 2.0, size.y / 2.0 + 10.0);
    var ball = Ball(
      radius: 4.0,
      position: ballPosition,
    );
    await add(ball);
    // add(Brick());
  }

  void setupGame() {
    for (int i = 0; i < numberOfBricksWidth; i++) {
      for (int j = 0; j < numberOfBricksHeight; j++) {}
    }
  }
}

class Ball extends BodyComponent {
  final Vector2 position;
  final double radius;

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
}

class Brick extends BodyComponent {
  void foo() {}

  @override
  Body createBody() {
    var color = Colors.blue;
    var shape = CircleShape();
    shape.radius = 5;

    var fixture = FixtureDef(shape, friction: 0.5);
    var bodyDef = BodyDef(position: Vector2(20, 5), type: BodyType.static);

    var body = world.createBody(bodyDef);
    var f = body.createFixture(fixture);

    return body;
  }
}

class Paddle extends PositionComponent {
  Color color = Colors.white;
}
