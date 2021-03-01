import 'package:flutter/material.dart';

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
                painter: FaceOutlinePainter(),
                child: Container(
                  color: Colors.green.withOpacity(0.5),
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
