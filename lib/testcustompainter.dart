import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomPainterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("CustomPainter"),
        ),
        body: Column(
          children: [
            Container(
              height: 100,
              color: Colors.green,
            ),
            Container(
              height: 300,
              color: Colors.blue,
            ),
            CustomPaint(
                painter: SineWavePainter(),
                child: Container(
                  color: Colors.green.withOpacity(0.1),
                  // width: 15,
                  height: 300,
                  // child: Text("OK"),
                )),
          ],
        ),
      ),
    );
  }
}

// Size CustomPaint
// Container(
//           color: Colors.white,
//           padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
//           child: LayoutBuilder(
//               builder: (_, contraints) => Container(
//                     width: contraints.widthConstraints().maxWidth,
//                     height: contraints.heightConstraints().maxHeight,
//                     color: Colors.yellow,
//                     child: CustomPaint(
//                       painter: FaceOutlinePainter(),
//                     ),
//                   )),
//         )

class FaceOutlinePainter extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    // TODO: Draw here
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.indigo;

    //
    canvas.drawRect(
      Rect.fromLTWH(20, 30, 100, 100),
      paint,
    );

    //
    canvas.drawOval(Rect.fromLTWH(120, 40, 100, 100), paint);
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) => false;
}

class SineWavePainter extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.black;

    // Draw Rect
    canvas.drawRect(
        Rect.fromLTWH(10, 10, size.width - 20, size.height - 20), paint);

    // Red painter
    final redPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.red;

    // Draw sine wave
    var amp = (size.height - 20) / 2.0;
    var yoffset = 10.0 + (size.height - 20) / 2.0;
    var dx1 = 10.0;
    var dy1 = yoffset + amp * math.sin(0.0);
    var dx2 = 10.0 + (size.width - 20.0) / 100.0;
    var dy2 = yoffset + amp * math.sin(2.0 * math.pi / 100.0);

    for (var i = 0; i < 100; i++) {
      canvas.drawLine(Offset(dx1, dy1), Offset(dx2, dy2), redPaint);
      dx1 = 10.0 + i * (size.width - 20.0) / 100.0;
      dx2 = 10.0 + (i + 1) * (size.width - 20.0) / 100.0;
      dy1 = yoffset + amp * math.sin(2.0 * math.pi * i / 100.0);
      dy2 = yoffset + amp * math.sin(2.0 * math.pi * (i + 1) / 100.0);
    }
  }

  @override
  bool shouldRepaint(SineWavePainter oldDelegate) => false;
}
