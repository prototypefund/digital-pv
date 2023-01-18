import 'dart:math';

import 'package:flutter_gen/gen_l10n/l10n.dart';

class TreatmentGoal {
  static const double valueUpperBound = 1;
  static const double valueLowerBound = -1;

  TreatmentGoal({required double value}) : value = _restrictValueToValidBounds(value);

  static double _restrictValueToValidBounds(double valueToCheck) {
    return max(min(valueToCheck, valueUpperBound), valueLowerBound);
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
