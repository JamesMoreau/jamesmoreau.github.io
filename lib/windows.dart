import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_website/constants.dart';
import 'package:my_website/main.dart';
import 'package:statsfl/statsfl.dart';

// This is the widget that holds all the windows.
class WindowArea extends StatefulWidget {

  final WindowController windowController;

  const WindowArea({Key? key, required this.windowController}) : super(key: key);

  @override
  WindowAreaState createState() => WindowAreaState();
}

class WindowAreaState extends State<WindowArea> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: widget.windowController.windows.map((e){
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

// This class manages the windows.
class WindowController {
  WindowController(this.onUpdate);

  List<ResizableWindow> windows = List.empty(growable: true);

  VoidCallback onUpdate;

  void addCalculatorWindow() {
    createNewWindow(title: "Calculator", body: const SimpleCalculator());
  }

  void createNewWindow({required String title, required Widget body, double width = -1, double height = -1, double x = -1, double y = -1}) {
   
   ResizableWindow resizableWindow = ResizableWindow(title, body);

    // Set initial position if none supplied.
    var rng = Random();
    x == -1 ? resizableWindow.x = rng.nextDouble() * 600 : resizableWindow.x = x;
    y == -1 ? resizableWindow.y = rng.nextDouble() * 600: resizableWindow.y = y;

    // Set initial dimensions if none supplied.
    width == -1  ? resizableWindow.width  = 400 : resizableWindow.width = width;
    height == -1 ? resizableWindow.height = 400 : resizableWindow.height = height;

    resizableWindow.onWindowFocus = () {

      // Put on top of stack.
      windows.remove(resizableWindow);
      windows.add(resizableWindow);

      onUpdate();
    };

    resizableWindow.onWindowClosed = () {
      windows.remove(resizableWindow);
      onUpdate();
    };

    windows.add(resizableWindow);

    // Update Widgets after adding the new App
    onUpdate();
  }

  closeAllWindows() {
    windows.clear();
    onUpdate();
  }

  void addAboutWindow() { 
    var bodyText =  
'''Hello, and welcome to my website. This site is all about myself, so if you aren't interested in me, then feel free to close this window!
                        
I use this site to showcase my work, and write about what I'm up to.
                       
This site was implemented using Flutter (a UI software development kit created by Google) and is compiled to target the web, so it is unlike a traditional javascript/html website.

Try moving around some windows.''';

    createNewWindow(title: "About This Site", width: 300, height: 340, x: 100, y: 20, body: 
      Container(
        color: MyColors.grey,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(bodyText, style: GoogleFonts.ptSerif(color: MyColors.white))
          ],
        ),
      )
    );
  }

  void addColorPickerWindow(Color c, void Function(Color c) colorChangeCallback) {
    var title = "Try Changing the color!";

    createNewWindow(title: title, width: 300, height: 220, x: 100, y: 390, body: 
      Container(
        color: MyColors.grey,
        child: SlidePicker(
          pickerColor: c,
          onColorChanged: colorChangeCallback,
          enableAlpha: false,
          showParams: false,
          showIndicator: false,
        ),
      )
    );
  }

  void addMetricsWindow() {
    var title = "App Metrics";

    createNewWindow(title: title, width: 150, height: 120, body: 
      Container(
        color: MyColors.grey,
        child: StatsFl(maxFps: 300),
      )
    );
  }
}

// This is the actual window widget.
class ResizableWindow extends StatefulWidget {
  final String title;
  final Widget body;
  double height = -1;
  double width = -1;
  double x = -1;
  double y = -1;

  void Function()? onWindowClosed;
  void Function()? onWindowFocus;

  ResizableWindow(this.title, this.body) : super(key: UniqueKey());

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
        widget.onWindowFocus!();

        setState(() {
          widget.x += tapInfo.delta.dx;
          widget.y += tapInfo.delta.dy;
        });
      },
      child: Container(
        width: widget.width,
        height: headerSize,
        color: MyColors.darkGrey,
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: (){
                  widget.onWindowClosed!();
                },
                child: const Icon(Icons.circle,color: Colors.red,)
              ),
            ),
            Positioned.fill(child: Center(child: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))),
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
