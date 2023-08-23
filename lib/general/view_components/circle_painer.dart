import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/colors.dart';

class CirclePainter extends CustomPainter {
  CirclePainter({Color? strokeColor}) : strokeColor = strokeColor ?? DefaultThemeColors.cyan;

  final Color strokeColor;
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, 100, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
