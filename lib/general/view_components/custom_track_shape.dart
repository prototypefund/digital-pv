import 'package:flutter/material.dart';

class CustomTrackShape extends RectangularSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
  }) {
    if (!isEnabled) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final double trackHeight = sliderTheme.trackHeight!;

    final Paint activeTrackPaint = Paint()
      ..color = sliderTheme.activeTrackColor!
      ..style = PaintingStyle.fill;

    final Paint inactiveTrackPaint = Paint()
      ..color = sliderTheme.inactiveTrackColor!.withOpacity(1.0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final Rect activeTrackRect =
        Rect.fromLTWH(trackRect.left, trackRect.top, thumbCenter.dx - trackRect.left, trackHeight);

    final Rect inactiveTrackRect =
        Rect.fromLTWH(thumbCenter.dx, trackRect.top, trackRect.right - thumbCenter.dx, trackHeight);

    context.canvas.drawRRect(RRect.fromRectAndRadius(activeTrackRect, const Radius.circular(25.0)), activeTrackPaint);

    context.canvas
        .drawRRect(RRect.fromRectAndRadius(inactiveTrackRect, const Radius.circular(25.0)), inactiveTrackPaint);
  }
}
