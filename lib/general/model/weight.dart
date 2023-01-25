import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

part 'weight.g.dart';

@JsonSerializable()
class Weight {
  Weight({required double value}) : value = _restrictValueToValidBounds(value);

  factory Weight.fromJson(Map<String, dynamic> json) => _$WeightFromJson(json);

  /// weight between 0 (no importance) and 1 (maximum importance)
  double value;

  static const double valueUpperBound = 1;
  static const double valueLowerBound = 0;

  static double _restrictValueToValidBounds(double valueToCheck) {
    return max(min(valueToCheck, valueUpperBound), valueLowerBound);
  }

  Map<String, dynamic> toJson() => _$WeightToJson(this);
}
