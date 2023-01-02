import 'package:flutter_gen/gen_l10n/l10n.dart';

enum TreatmentActivity { notSpecified, no, yes, symptomControl }

extension TreatmentActivityLocalization on TreatmentActivity {
  String localizedString(L10n l10n) {
    switch (this) {
      case TreatmentActivity.notSpecified:
        return l10n.treatmentActivityNotSpecified;
      case TreatmentActivity.no:
        return l10n.treatmentActivityNo;
      case TreatmentActivity.yes:
        return l10n.treatmentActivityYes;
      case TreatmentActivity.symptomControl:
        return l10n.treatmentActivitySymptomControl;
    }
  }
}
