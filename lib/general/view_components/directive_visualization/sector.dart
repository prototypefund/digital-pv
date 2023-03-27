import 'package:pd_app/general/view_components/directive_visualization/coordinate.dart';

class Sector {
  final double angle;
  final double radius;

  /// coefficients that define Coordinates of the aspects inside of the provided Sector
  static const double _innerRadiusCoefficient = 0.3;
  static const double _outerRadiusCoefficient = 0.6;

  static const double _rightAngleCoefficient = 0.2;
  static const double _leftAngleCoefficient = 0.8;
  static const double _middleAngleCoefficient = 0.5;

  const Sector({required this.angle, required this.radius});

  /// Sector has 4 different coordinates for the aspects
  Coordinate get outerMiddleCoordinate =>
      Coordinate(radius: radius * _outerRadiusCoefficient, angle: angle * _middleAngleCoefficient);

  Coordinate get innerMiddleCoordinate =>
      Coordinate(radius: radius * _innerRadiusCoefficient, angle: angle * _middleAngleCoefficient);

  Coordinate get outerLeftCoordinate =>
      Coordinate(radius: radius * _outerRadiusCoefficient, angle: angle * _leftAngleCoefficient);

  Coordinate get outerRightCoordinate =>
      Coordinate(radius: radius * _outerRadiusCoefficient, angle: angle * _rightAngleCoefficient);
}
