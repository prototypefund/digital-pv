class Weight {
  /// weight between 0 (no importance) and 1 (maximum importance)
  final double value;

  Weight({required this.value}) {
    _validateWeightInRange(value);
  }

  void _validateWeightInRange(double weightToCheck) {
    if (value < 0 || weightToCheck > 1) {
      throw InvalidWeightException();
    }
  }
}

class InvalidWeightException implements Exception {}
