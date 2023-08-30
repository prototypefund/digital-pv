import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/colors.dart';

class BorderSliderThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final double borderThickness;
  final Color borderColor;

  BorderSliderThumbShape(
      {this.thumbRadius = 6, this.borderThickness = 2, this.borderColor = DefaultThemeColors.magenta});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = borderThickness
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, thumbRadius, borderPaint);

    final Paint thumbPaint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius, thumbPaint);
  }
}
