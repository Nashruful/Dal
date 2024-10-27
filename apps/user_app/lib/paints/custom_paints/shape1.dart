  import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
      Paint paint = Paint();
      Path path = Path();
  

      // Path number 1
  

      paint.color = Color(0xffF6EFDE);
      path = Path();
      path.lineTo(-0.36, -0.01);
      path.cubicTo(-0.36, -0.01, size.width * 0.64, -0.01, size.width * 0.64, -0.01);
      path.cubicTo(size.width * 0.64, -0.01, size.width * 0.64, size.height, size.width * 0.64, size.height);
      path.cubicTo(size.width * 0.64, size.height, -0.36, size.height, -0.36, size.height);
      path.cubicTo(-0.36, size.height, -0.36, -0.01, -0.36, -0.01);
      canvas.drawPath(path, paint);
    }
    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
      return true;
    }
  }
