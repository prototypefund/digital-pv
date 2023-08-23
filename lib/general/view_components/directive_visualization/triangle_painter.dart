import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/colors.dart';

enum TipDirection {
  left,
  right,
  up,
  down,
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final TipDirection tipDirection;
  ValueNotifier<bool> isHovering = ValueNotifier(false);

  TrianglePainter({
    this.strokeColor = DefaultThemeColors.magenta,
    this.strokeWidth = 10,
    this.paintingStyle = PaintingStyle.stroke,
    this.tipDirection = TipDirection.left,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint shadowPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    final Paint trianglePaint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.save();

    if (isHovering.value) {
      canvas.drawPath(getTrianglePath(size.width + 10, size.height + 10), shadowPaint);
    }

    canvas.drawPath(getTrianglePath(size.width, size.height), trianglePaint);

    canvas.restore();
  }

  Path getTrianglePath(double width, double height) {
    switch (tipDirection) {
      case TipDirection.left:
        return Path()
          ..moveTo(0, height / 2)
          ..lineTo(width, 0)
          ..lineTo(width, height)
          ..close();
      case TipDirection.right:
        return Path()
          ..moveTo(width, height / 2)
          ..lineTo(0, 0)
          ..lineTo(0, height)
          ..close();
      case TipDirection.up:
        return Path()
          ..moveTo(width / 2, 0)
          ..lineTo(width, height)
          ..lineTo(0, height)
          ..close();
      case TipDirection.down:
        return Path()
          ..moveTo(width / 2, height)
          ..lineTo(width, 0)
          ..lineTo(0, 0)
          ..close();
    }
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
