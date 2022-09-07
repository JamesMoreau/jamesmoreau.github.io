import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'resizable_window.dart';

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

    ResizableWindow resizableWindow = ResizableWindow(title: title, body: body, height: height, x: x, y: y, onWindowDragged: (p0, p1) {});
    //Init onWindowDragged
    resizableWindow.onWindowDragged = (dx,dy) {

      resizableWindow.x += dx;
      resizableWindow.y += dy;

      //Put on top of stack
      windows.remove(resizableWindow);
      windows.add(resizableWindow);

      onUpdate();
    };

    //Init onCloseButtonClicked
    resizableWindow.onCloseButtonClicked = () {
      windows.remove(resizableWindow);
      onUpdate();
    };


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