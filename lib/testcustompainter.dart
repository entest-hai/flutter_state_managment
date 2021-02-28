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
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
          child: LayoutBuilder(
              builder: (_, contraints) => Container(
                    width: contraints.widthConstraints().maxWidth,
                    height: contraints.heightConstraints().maxHeight,
                    color: Colors.yellow,
                    child: CustomPaint(
                      painter: FaceOutlinePainter(),
                    ),
                  )),
        ),
      ),
    );
  }
}

class FaceOutlinePainter extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    // TODO: Draw here
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
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
