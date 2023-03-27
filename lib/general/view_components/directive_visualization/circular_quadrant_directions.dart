import 'dart:math' as math;

mixin CircularQuadrantDirections {
  static const double bottomLeftQuadrantLowerBound = math.pi / 2;
  static const double bottomLeftQuadrantUpperBound = math.pi;

  static const double bottomRightLowerBound = 0;
  static const double bottomRightUpperBound = math.pi / 2;

  static const double topLeftLowerBound = -math.pi;
  static const double topLeftUpperBound = -math.pi / 2;

  static const double topRightLowerBound = -math.pi / 2;
  static const double topRightUpperBound = 0;

  static const double leftCenter = -math.pi;
  static const double rightCenter = 0;
  static const double topCenter = -math.pi / 2;
  static const double bottomCenter = math.pi / 2;

  bool isBottomLeftQuadrant(double direction) =>
      CircularQuadrantDirections.bottomLeftQuadrantLowerBound < direction &&
      direction < CircularQuadrantDirections.bottomLeftQuadrantUpperBound;

  bool isBottomRightQuadrant(double direction) =>
      bottomRightLowerBound < direction && direction <= bottomRightUpperBound;

  bool isTopRightQuadrant(double direction) => topRightLowerBound < direction && direction <= topRightUpperBound;

  bool isTopLeftQuadrant(double direction) => topLeftLowerBound < direction && direction <= topLeftUpperBound;
}
