import 'dart:math';

import 'package:flutter/material.dart';

class ResizableWindow extends StatefulWidget {
  String title;
  Widget body;
  double height;
  double width;
  double x;
  double y;
  Function(double, double)? onWindowDragged;
  VoidCallback? onCloseButtonClicked;

  ResizableWindow({required this.title, required this.body, this.width = 400, this.height = 400, this.x = -1, this.y = -1, this.onWindowDragged, this.onCloseButtonClicked}) : super(key: UniqueKey()) {
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
                  onHorizontalDragUpdate: _onHorizontalDragRight,
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
                  onHorizontalDragUpdate: _onHorizontalDragLeft,
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
                  onVerticalDragUpdate: _onHorizontalDragTop,
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
                  onVerticalDragUpdate: _onHorizontalDragBottom,
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
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpLeftDownRight,
                    opaque: true,
                    child: Container(
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
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpRightDownLeft,
                    opaque: true,
                    child: Container(
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
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpRightDownLeft,
                    opaque: true,
                    child: Container(
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
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpLeftDownRight,
                    opaque: true,
                    child: Container(
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


  void _onHorizontalDragLeft(DragUpdateDetails details) {
    setState(() {
      widget.width -= details.delta.dx;
      if (widget.width < widget.width) {
        widget.width = widget.width;
      } else {
        widget.onWindowDragged!(details.delta.dx, 0);
      }
    });
  }

  void _onHorizontalDragRight(DragUpdateDetails details) {
    setState(() {
      widget.width += details.delta.dx;
      if (widget.width < widget.width) {
        widget.width = widget.width;
      }
    });
  }

  void _onHorizontalDragBottom(DragUpdateDetails details) {

    setState(() {
      widget.height += details.delta.dy;
      if (widget.height < widget.height) {
        widget.height = widget.height;
      }
    });
  }

  void _onHorizontalDragTop(DragUpdateDetails details) {

    setState(() {
      widget.height -= details.delta.dy;
      if (widget.height < widget.height) {
        widget.height = widget.height;
      } else {
        widget.onWindowDragged!(0, details.delta.dy);
      }
    });
  }

  void _onHorizontalDragBottomRight(DragUpdateDetails details) {
    _onHorizontalDragRight(details);
    _onHorizontalDragBottom(details);
  }

  void _onHorizontalDragBottomLeft(DragUpdateDetails details) {
    _onHorizontalDragLeft(details);
    _onHorizontalDragBottom(details);
  }

  void _onHorizontalDragTopRight(DragUpdateDetails details) {
    _onHorizontalDragRight(details);
    _onHorizontalDragTop(details);
  }

  void _onHorizontalDragTopLeft(DragUpdateDetails details) {
    _onHorizontalDragLeft(details);
    _onHorizontalDragTop(details);
  }

}
