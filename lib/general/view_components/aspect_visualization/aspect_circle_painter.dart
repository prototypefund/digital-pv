import 'package:flutter/widgets.dart';
import 'package:pd_app/general/view_components/aspect_visualization/coordinate.dart';

class AspectCirclePainter extends CustomPainter {
  const AspectCirclePainter({
    required this.coordinate,
    required this.radius,
    required this.gradient,
  });

  final Coordinate coordinate;
  final double radius;
  final Gradient gradient;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(coordinate.x, coordinate.y);

    final paint = Paint()..shader = gradient.createShader(center & Size(radius, radius));

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
