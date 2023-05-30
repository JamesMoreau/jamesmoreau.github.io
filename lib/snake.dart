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

class MyGame extends FlameGame with KeyboardEvents {
  late Main main;

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    var isKeyDown = event is RawKeyDownEvent;
    if (!isKeyDown) return KeyEventResult.ignored;

    var isSpace = keysPressed.contains(LogicalKeyboardKey.space);
    var isUp = keysPressed.contains(LogicalKeyboardKey.arrowUp);
    var isRight = keysPressed.contains(LogicalKeyboardKey.arrowRight);
    var isDown = keysPressed.contains(LogicalKeyboardKey.arrowDown);
    var isLeft = keysPressed.contains(LogicalKeyboardKey.arrowLeft);

    if (isSpace) {
      print('got a space!');
      return KeyEventResult.handled;
    } else if (isUp) {
      print('got a up arrow');
      return KeyEventResult.handled;
    } else if (isRight) {
      print('got a right arrow');
      return KeyEventResult.handled;
    } else if (isDown) {
      print('got a down arrow');
      return KeyEventResult.handled;
    } else if (isLeft) {
      print('got a left arrow');
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  void onLoad() {
    debugMode = true;
    main = Main();
    add(main);

    // grid = GridComponent();
    // add(grid);

    super.onLoad();
  }

  // @override
  // void render(Canvas canvas) {
  //   // var circle = Rect.;
  //   // canvas.drawCircle(canvas., radius, paint)

  // }
}

class Main extends Component with HasGameRef, KeyboardHandler {
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

// class GridComponent extends Component with HasGameRef {
//   static const gridSize = 10;
//   double cellSize = 0;

//   @override
//   void render(Canvas canvas) {
//     var size = gameRef.size;
//     cellSize = size.x / gridSize;

//     super.render(canvas);

//     // Render the grid
//     var paint = Paint();
//     paint.color = Colors.blue;
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 2;

//     for (var i = 0; i <= gridSize; i++) {
//       final x = i * cellSize;
//       final y = i * cellSize;
//       canvas.drawLine(Offset(x, 0), Offset(x, cellSize * gridSize), paint);
//       canvas.drawLine(Offset(0, y), Offset(cellSize * gridSize, y), paint);
//     }
//   }
// }

// class Square extends RectangleComponent with TapCallbacks {
//   static const speed = 3;
//   static const squareSize = 128.0;
//   static const indicatorSize = 6.0;

//   static Paint red = BasicPalette.red.paint();
//   static Paint blue = BasicPalette.blue.paint();

//   Square(Vector2 position)
//       : super(
//           position: position,
//           size: Vector2.all(squareSize),
//           anchor: Anchor.center,
//         );

//   @override
//   void update(double dt) {
//     super.update(dt);
//     angle += speed * dt;
//     angle %= 2 * math.pi;
//   }

//   @override
//   Future<void> onLoad() async {
//     super.onLoad();
//     add(
//       RectangleComponent(
//         size: Vector2.all(indicatorSize),
//         paint: blue,
//       ),
//     );
//     add(
//       RectangleComponent(
//         position: size / 2,
//         size: Vector2.all(indicatorSize),
//         anchor: Anchor.center,
//         paint: red,
//       ),
//     );
//   }

//   @override
//   void onTapDown(TapDownEvent event) {
//     removeFromParent();
//     event.handled = true;
//   }
// }

// Color getCellColor(CellType cellType) => switch (cellType) {
//       CellType.SNAKE => Colors.yellow,
//       CellType.EMPTY => Colors.grey,
//       CellType.FOOD => Colors.green
//     };

Color getRandomColor() {
  var random = math.Random();
  var r = random.nextInt(256);
  var g = random.nextInt(256);
  var b = random.nextInt(256);
  return Color.fromRGBO(r, g, b, 1.0);
}
