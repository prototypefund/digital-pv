import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/treatment_activity.dart';

class FutureSituation extends Aspect {
  FutureSituation({required super.name, required super.weight});

  TreatmentActivityChoice hospitalizationPreference = TreatmentActivityChoice.notSpecified;
  TreatmentActivityChoice intensiveTreatmentPreference = TreatmentActivityChoice.notSpecified;
  TreatmentActivityChoice resuscitationPreference = TreatmentActivityChoice.notSpecified;
}
