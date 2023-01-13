import 'package:flutter_gen/gen_l10n/l10n.dart';

class TreatmentGoal {
  TreatmentGoal({required this.value}) {
    _validateTreatmentGoalValueInRange(value);
  }

  void _validateTreatmentGoalValueInRange(double valueToCheck) {
    if (!((valueToCheck < 1) || (valueToCheck > -1))) {
      throw InvalidTreatmentGoalValueException();
    }
  }

  // a value between -1 (palliative) and +1 (curative)
  final double value;

  TreatmentGoalTendency get tendency {
    if (value < 0) {
      return TreatmentGoalTendency.palliative;
    } else if (value == 0) {
      return TreatmentGoalTendency.undefined;
    } else {
      return TreatmentGoalTendency.curative;
    }
  }
}

class InvalidTreatmentGoalValueException implements Exception {}

enum TreatmentGoalTendency { undefined, curative, palliative }

extension TreatmentGoalTendencyLocalization on TreatmentGoalTendency {
  String localizedString(L10n l10n) {
    switch (this) {
      case TreatmentGoalTendency.undefined:
        return l10n.treatmentGoalUndefined;
      case TreatmentGoalTendency.curative:
        return l10n.treatmentGoalCurative;
      case TreatmentGoalTendency.palliative:
        return l10n.treatmentGoalPalliative;
    }
  }
}
