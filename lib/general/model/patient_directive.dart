import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/treatment_activity.dart';
import 'package:pd_app/general/model/treatment_goal.dart';

class PatientDirective {
  PatientDirective({required this.positiveAspects, required this.futureSituationAspects, required this.treatmentGoal});

  final List<Aspect> positiveAspects;
  final List<Aspect> futureSituationAspects;
  final TreatmentGoal treatmentGoal;

  TreatmentActivity generalHospitalizationPreference = TreatmentActivity.notSpecified;
  TreatmentActivity generalIntensiveTreatmentPreference = TreatmentActivity.notSpecified;
  TreatmentActivity generalResuscitationPreference = TreatmentActivity.notSpecified;
}
