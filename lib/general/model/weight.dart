import 'dart:math';

class Weight {
  /// weight between 0 (no importance) and 1 (maximum importance)
  final double value;

  static const double valueUpperBound = 1;
  static const double valueLowerBound = 0;

  Weight({required double value}) : value = _restrictValueToValidBounds(value);

  static double _restrictValueToValidBounds(double valueToCheck) {
    return max(min(valueToCheck, valueUpperBound), valueLowerBound);
  }
}
