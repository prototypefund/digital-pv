import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/treatment_activity.dart';

class FutureSituation extends Aspect {
  FutureSituation(
      {required super.name,
      required super.weight,
      this.hospitalizationPreference = TreatmentActivityChoice.notSpecified,
      this.intensiveTreatmentPreference = TreatmentActivityChoice.notSpecified,
      this.resuscitationPreference = TreatmentActivityChoice.notSpecified});

  TreatmentActivityChoice hospitalizationPreference;
  TreatmentActivityChoice intensiveTreatmentPreference;
  TreatmentActivityChoice resuscitationPreference;
}
