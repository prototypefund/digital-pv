import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/model/treatment_activity.dart';
import 'package:pd_app/general/model/treatment_goal.dart';

class PatientDirective {
  PatientDirective(
      {required this.positiveAspects, required this.futureSituationAspects, required this.generalTreatmentGoal});

  final List<Aspect> positiveAspects;
  final List<FutureSituation> futureSituationAspects;

  final TreatmentGoal generalTreatmentGoal;

  TreatmentActivityChoice generalHospitalizationPreference = TreatmentActivityChoice.notSpecified;
  TreatmentActivityChoice generalIntensiveTreatmentPreference = TreatmentActivityChoice.notSpecified;
  TreatmentActivityChoice generalResuscitationPreference = TreatmentActivityChoice.notSpecified;
}
