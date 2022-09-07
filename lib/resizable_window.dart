import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_website/window_manager.dart';

class ResizableWindow extends StatefulWidget {
  String title;
  Widget body;
  double height;
  double width;
  double x;
  double y;
  Function(double, double)? onWindowDragged;
  VoidCallback? onCloseButtonClicked;

  // Window need a pointer to the window manager so it can refresh state.
  WindowManager? windowManager;

  ResizableWindow({required this.title, required this.body, this.width = 400, this.height = 400, this.x = -1, this.y = -1, this.onWindowDragged, this.onCloseButtonClicked}) : super(key: UniqueKey()) {
    var rng = Random();
    var num = 500;
    if (x == -1) x = rng.nextDouble() * num;
    if (y == -1) y = rng.nextDouble() * num;

    windowManager = null;
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
                  onPanUpdate: _onHorizontalDragBottomRight,
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
                  onPanUpdate: _onHorizontalDragBottomLeft,
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
                  onPanUpdate: _onHorizontalDragTopRight,
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
                  onPanUpdate: _onHorizontalDragTopLeft,
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
        widget.onWindowDragged!(tapInfo.delta.dx, tapInfo.delta.dy);
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
                  widget.onCloseButtonClicked!();
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
      widget.onWindowDragged!(details.delta.dx, 0);
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
      widget.onWindowDragged!(0, details.delta.dy);
    });
  }

  void _onHorizontalDragBottomRight(DragUpdateDetails details) {
    onHorizontalDragRight(details);
    onHorizontalDragBottom(details);
  }

  void _onHorizontalDragBottomLeft(DragUpdateDetails details) {
    onHorizontalDragLeft(details);
    onHorizontalDragBottom(details);
  }

  void _onHorizontalDragTopRight(DragUpdateDetails details) {
    onHorizontalDragRight(details);
    onHorizontalDragTop(details);
  }

  void _onHorizontalDragTopLeft(DragUpdateDetails details) {
    onHorizontalDragLeft(details);
    onHorizontalDragTop(details);
  }

}
