import 'dart:math';

class Coordinate {
  final double angle;
  final double radius;

  const Coordinate({required this.angle, required this.radius});

  /// Polar to Cartesian coordinate transformation
  double get x => radius * cos(angle);
  double get y => radius * sin(angle);

  @override
  String toString() {
    return 'Coordinate: {radius: $radius, angle: $angle}';
  }
}
