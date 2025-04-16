import 'dart:ui';

import 'package:flutter/material.dart';

const noise = 'assets/noise.png';

// This widget overlays a "CRT" emulated filter on top of the child widget (usually the entire app).
class CRTFilter extends StatelessWidget {
  final Widget child;
  final bool enabled;

  const CRTFilter({required this.child, super.key, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    return Stack(
      children: [
        child, // App content
        Positioned.fill(child: IgnorePointer(child: CustomPaint(painter: CRTScanLinesPainter()))), // Draw CRT scan lines
        Positioned.fill(
          // Blur effect
          child: IgnorePointer(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: .7, sigmaY: .7),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CRTScanLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.black.withValues(alpha: 0.04);
    paint.style = PaintingStyle.fill;

    var lineSpacing = 4;

    for (var y = 0.0; y < size.height; y += lineSpacing) {
      canvas.drawRect(Rect.fromLTWH(0, y, size.width, 1), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// class CRTVignettePainter extends CustomPainter {
//   final double borderThickness;
//   final Color borderColor;
//   final double blurSigma;

//   CRTVignettePainter({
//     required this.borderThickness,
//     required this.borderColor,
//     required this.blurSigma,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     var rect = Offset.zero & size;
//     var paint = Paint();
//     paint.color = borderColor;
//     paint.maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = borderThickness;

//     canvas.drawRect(rect, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

// class CRTNoisePainter extends CustomPainter {
//   String noiseImagePath;
//   Image? noiseImage;

//   CRTNoisePainter(this.noiseImagePath);

//   @override
//   void paint(Canvas canvas, Size size) {
//     var image = noiseImage;
//     if (image == null) return;

//     var width = image.width!;
//     var height = image.height!;

//     var noisePaint = Paint();
//     noisePaint.color = Colors.black.withOpacity(1);

//     // Tile the noise image across the screen
//     for (var x = 0.0; x < size.width; x += width) {
//       for (var y = 0.0; y < size.height; y += height) {
//         final rect = Offset(x, y) & Size(width, height);
//         var noisePaint = Paint();
//         canvas.drawImageRect(image as ui.Image, Rect.fromLTWH(0, 0, width, height), rect, noisePaint);
//         print('Drawing noise at $x, $y');
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }

// Future<void> loadNoise() async {
//   final path = widget.noiseFilePath;
//   if (path == null || path.isEmpty) return;

//   var imageData = await rootBundle.load(path);
//   var imageBytes = imageData.buffer.asUint8List();

//   ui.decodeImageFromList(imageBytes, (data) {
//     noiseImage = data;
//     setState(() {});
//     print('Loaded noise image');
//   });
// }
