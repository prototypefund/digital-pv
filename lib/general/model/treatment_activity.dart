import 'package:flutter_gen/gen_l10n/l10n.dart';

enum TreatmentActivityChoice { notSpecified, no, yes, symptomControl }

extension TreatmentActivityChoiceLocalization on TreatmentActivityChoice {
  String localizedString(L10n l10n) {
    switch (this) {
      case TreatmentActivityChoice.notSpecified:
        return l10n.treatmentActivityNotSpecified;
      case TreatmentActivityChoice.no:
        return l10n.treatmentActivityNo;
      case TreatmentActivityChoice.yes:
        return l10n.treatmentActivityYes;
      case TreatmentActivityChoice.symptomControl:
        return l10n.treatmentActivitySymptomControl;
    }
  }
}
