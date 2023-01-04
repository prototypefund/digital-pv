import 'package:flutter_gen/gen_l10n/l10n.dart';

enum TreatmentGoal { undefined, curative, palliative }

extension TreatmentGoalLocalization on TreatmentGoal {
  String localizedString(L10n l10n) {
    switch (this) {
      case TreatmentGoal.undefined:
        return l10n.treatmentGoalUndefined;
      case TreatmentGoal.curative:
        return l10n.treatmentGoalCurative;
      case TreatmentGoal.palliative:
        return l10n.treatmentGoalPalliative;
    }
  }
}
