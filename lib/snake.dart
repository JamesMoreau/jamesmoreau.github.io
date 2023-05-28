import 'dart:math' as math;
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

enum CellType { SNAKE, EMPTY, FOOD }

enum SnakeDirection { NORTH, EAST, SOUTH, WEST }

class Position {
  int x = 0;
  int y = 0;

  Position(this.x, this.y);
}

class MyGame extends FlameGame {
  late Main main;
  late GridComponent grid;

  @override
  void onLoad() {
    debugMode = true;
    main = Main();
    add(main);

    grid = GridComponent();
    add(grid);

    super.onLoad();
  }

  // @override
  // void render(Canvas canvas) {
  //   // var circle = Rect.;
  //   // canvas.drawCircle(canvas., radius, paint)

  // }
}

class Main extends Component with HasGameRef {
  double cellSize = 10;
  int gridSize = 10;
  int borderWidth = 2;

  Position food = Position(0, 0);
  List<Position> snake = [Position(0, 0), Position(0, 1), Position(0, 2)];
  SnakeDirection direction = SnakeDirection.SOUTH;

  @override
  void onLoad() {
    // snakeGrid = List.filled(columns, List.filled(rows, CellType.EMPTY));
    // snakeGrid[0][0] = CellType.SNAKE;
    // snakeGrid[1][1] = CellType.FOOD;

    // var s = snakeGrid.toString();
    // debugPrint('GRID STRING: ' + s);

    while (true) {
      food.x = Random().nextInt(gridSize);
      food.y = Random().nextInt(gridSize);
    }

  }

  @override
  void render(Canvas canvas) {
    cellSize = gameRef.canvasSize.x / gridSize;
    // for (int row = 0; row < rows; row++) {
    //   for (int col = 0; col < columns; col++) {

    // var cell = snakeGrid[row][col];
    // double x = (col * cellSize);
    // double y = (row * cellSize);

    // Rect tileRect = Rect.fromLTRB(100 + x, 100 + y, cellSize, cellSize);
    // canvas.drawRect(tileRect, Paint()..color = getCellColor(cell));

    // print('drawing cell');
    // }
    // }

    // Draw snake
    for (var cell in snake) {
      assert(cell.x >= 0 && cell.x < gridSize && cell.y >= 0 && cell.y < gridSize,
          'Snake is not inside the grid.');

      var x = cell.x.toDouble() * cellSize;
      var y = cell.y.toDouble() * cellSize;
      Paint paint = Paint();
      paint.color = Colors.yellow;
      Rect tileRect = Rect.fromLTRB(x, y, x + cellSize, y + cellSize);
      canvas.drawRect(tileRect, paint);
    }

    if (food == null) return;

    // Draw Food
    var x = food.x.toDouble() * cellSize;
    var y = food.y.toDouble() * cellSize;
    var paint = Paint();
    paint.color = Colors.green;

    Rect tileRect = Rect.fromLTRB(x, y, x + cellSize, y + cellSize);
    canvas.drawRect(tileRect, paint);
  }

  @override
  void update(double dt) {
    // Update the grid component
    super.update(dt);
  }
}

class GridComponent extends Component with HasGameRef {
  static const gridSize = 10;
  double cellSize = 0;

  @override
  void render(Canvas canvas) {
    var size = gameRef.size;
    cellSize = size.x / gridSize;

    super.render(canvas);

    // Render the grid
    var paint = Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;

    for (var i = 0; i <= gridSize; i++) {
      final x = i * cellSize;
      final y = i * cellSize;
      canvas.drawLine(Offset(x, 0), Offset(x, cellSize * gridSize), paint);
      canvas.drawLine(Offset(0, y), Offset(cellSize * gridSize, y), paint);
    }
  }
}

class Square extends RectangleComponent with TapCallbacks {
  static const speed = 3;
  static const squareSize = 128.0;
  static const indicatorSize = 6.0;

  static Paint red = BasicPalette.red.paint();
  static Paint blue = BasicPalette.blue.paint();

  Square(Vector2 position)
      : super(
          position: position,
          size: Vector2.all(squareSize),
          anchor: Anchor.center,
        );

  @override
  void update(double dt) {
    super.update(dt);
    angle += speed * dt;
    angle %= 2 * math.pi;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(
      RectangleComponent(
        size: Vector2.all(indicatorSize),
        paint: blue,
      ),
    );
    add(
      RectangleComponent(
        position: size / 2,
        size: Vector2.all(indicatorSize),
        anchor: Anchor.center,
        paint: red,
      ),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    removeFromParent();
    event.handled = true;
  }
}

Color getCellColor(CellType cellType) => switch (cellType) {
      CellType.SNAKE => Colors.yellow,
      CellType.EMPTY => Colors.grey,
      CellType.FOOD => Colors.green
    };

Color getRandomColor() {
  final Random random = Random();
  final int r = random.nextInt(256);
  final int g = random.nextInt(256);
  final int b = random.nextInt(256);
  return Color.fromRGBO(r, g, b, 1.0);
}
