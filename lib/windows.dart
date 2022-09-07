import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';


// This is the widget that holds all the windows.
class WindowArea extends StatefulWidget {

  const WindowArea({Key? key}) : super(key: key);

  @override
  WindowAreaState createState() => WindowAreaState();
}

class WindowAreaState extends State<WindowArea> {
  List<ResizableWindow> windows = List.empty(growable: true);
  
  onUpdate() {
    setState(() {});
  }

  void addWindow(){
    createNewWindow(title: "Calculator", body: const SimpleCalculator());
  }

  void createNewWindow({required String title, required Widget body, double width = 400, double height = 400, double x = -1, double y = -1, dynamic Function(double, double)? onWindowDragged, VoidCallback? onCloseButtonClicked}) {

    onWindowFocus(Key key) {
      var window = windows.firstWhere((element) => element.key == key);
      
      // This takes pushes the window to the top of the stack.
      windows.remove(window);
      windows.add(window);

      onUpdate();
    }

    onWindowClosed(Key key) {
      var window = windows.firstWhere((element) => element.key == key);

      windows.remove(window);
      onUpdate();
    }

    ResizableWindow resizableWindow = ResizableWindow(key: UniqueKey(), title: title, body: body, height: height, x: x, y: y, onWindowFocus: onWindowFocus, onWindowClosed: onWindowClosed);

    //Add Window to List
    windows.add(resizableWindow);

    // Update Widgets after adding the new App
    onUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: windows.map((e){
        return Positioned(
          left: e.x,
          top: e.y,
          key: e.key,
          child: e,
        );
      }).toList()
    );
  }
}


// This is the actual window widget.
class ResizableWindow extends StatefulWidget {
  String title;
  Widget body;
  double height;
  double width;
  double x;
  double y;

  void Function(Key) onWindowClosed;
  void Function(Key) onWindowFocus;

  ResizableWindow({required Key key, required this.title, required this.body, this.width = 400, this.height = 400, this.x = -1, this.y = -1, required this.onWindowClosed, required this.onWindowFocus}) : super(key: key) {
    
    // Give the window radom position if none is supplied.
    var rng = Random();
    var num = 500;
    if (x == -1) x = rng.nextDouble() * num;
    if (y == -1) y = rng.nextDouble() * num;
  }

  @override
  ResizableWindowState createState() => ResizableWindowState();
}

class ResizableWindowState extends State<ResizableWindow> {
  final headerSize = 50.0;
  final borderRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x54000000),
              spreadRadius: 4,
              blurRadius: 5,
            ),
          ],
        ),
      child: ClipRRect(
        borderRadius:  BorderRadius.all(Radius.circular(borderRadius)),
        child: Stack(
          children: [
            Column(
              children: [getHeader(), getBody()],
            ),
            Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onHorizontalDragUpdate: onHorizontalDragRight,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeLeftRight,
                    opaque: true,
                    child: Container(
                      width: 4,
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onHorizontalDragUpdate: onHorizontalDragLeft,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeLeftRight,
                    opaque: true,
                    child: Container(
                      width: 4,
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: GestureDetector(
                  onVerticalDragUpdate: onHorizontalDragTop,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpDown,
                    opaque: true,
                    child: Container(
                      height: 4,
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onVerticalDragUpdate: onHorizontalDragBottom,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpDown,
                    opaque: true,
                    child: Container(
                      height: 4,
                    ),
                  ),
                )),
            Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onPanUpdate: onHorizontalDragBottomRight,
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.resizeUpLeftDownRight,
                    opaque: true,
                    child: SizedBox(
                      height: 6,
                      width: 6,
                    ),
                  ),
                )),
            Positioned(
                bottom: 0,
                left: 0,
                child: GestureDetector(
                  onPanUpdate: onHorizontalDragBottomLeft,
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.resizeUpRightDownLeft,
                    opaque: true,
                    child: SizedBox(
                      height: 6,
                      width: 6,
                    ),
                  ),
                )),
            Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onPanUpdate: onHorizontalDragTopRight,
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.resizeUpRightDownLeft,
                    opaque: true,
                    child: SizedBox(
                      height: 6,
                      width: 6,
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                top: 0,
                child: GestureDetector(
                  onPanUpdate: onHorizontalDragTopLeft,
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.resizeUpLeftDownRight,
                    opaque: true,
                    child: SizedBox(
                      height: 6,
                      width: 6,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  getHeader() {
    return GestureDetector(
      onPanUpdate: (tapInfo) {
        widget.onWindowFocus(widget.key!);

        widget.x += tapInfo.delta.dx;
        widget.y += tapInfo.delta.dy;
      },
      child: Container(
        width: widget.width,
        height: headerSize,
        color: Colors.lightBlueAccent,
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: (){
                  widget.onWindowClosed(widget.key!);
                },
                child: const Icon(Icons.circle,color: Colors.red,)
              ),
            ),
            Positioned.fill(child: Center(child: Text(widget.title))),
          ],
        ),
      ),
    );
  }

  getBody() {
    return Container(
      width: widget.width,
      height: widget.height - headerSize,
      color: Colors.blueGrey,
      child: widget.body,
    );
  }

  void onHorizontalDragLeft(DragUpdateDetails details) {
    setState(() {
      widget.width -= details.delta.dx;
      widget.x += details.delta.dx;
      widget.y += 0;
    });
  }

  void onHorizontalDragRight(DragUpdateDetails details) {
    setState(() {
      widget.width += details.delta.dx;
    });
  }

  void onHorizontalDragBottom(DragUpdateDetails details) {
    setState(() {
      widget.height += details.delta.dy;
    });
  }

  void onHorizontalDragTop(DragUpdateDetails details) {
    setState(() {
      widget.height -= details.delta.dy;
      widget.x += details.delta.dx;
      widget.y += details.delta.dy;
    });
  }

  void onHorizontalDragBottomRight(DragUpdateDetails details) {
    onHorizontalDragRight(details);
    onHorizontalDragBottom(details);
  }

  void onHorizontalDragBottomLeft(DragUpdateDetails details) {
    onHorizontalDragLeft(details);
    onHorizontalDragBottom(details);
  }

  void onHorizontalDragTopRight(DragUpdateDetails details) {
    onHorizontalDragRight(details);
    onHorizontalDragTop(details);
  }

  void onHorizontalDragTopLeft(DragUpdateDetails details) {
    onHorizontalDragLeft(details);
    onHorizontalDragTop(details);
  }

}
