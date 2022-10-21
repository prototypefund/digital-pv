import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/navigation/routes.dart';

class TreatmentActivitiesViewModel extends CreationProcessNavigationViewModel {
  String get addTreatmentActivitiesTitle => l10n.addTreatmentActivitiesTitle;

  String get addTreatmentActivitiesExplanation => l10n.addTreatmentActivitiesExplanation;
  String get addTreatmentActivitiesSubHeadline => l10n.addTreatmentActivitiesSubHeadline;
  String get addTreatmentActivitiesHospitalAdmission => l10n.addTreatmentActivitiesHospitalAdmission;
  String get addTreatmentActivitiesIntensiveTreatment => l10n.addTreatmentActivitiesIntensiveTreatment;
  String get addTreatmentActivitiesResuscitation => l10n.addTreatmentActivitiesResuscitation;

  late String? hospitalizationSelection = hospitalizationList.first;
  late String? intensiveTreatmentSelection = intensiveTreatmentList.first;
  late String? resuscitationSelection = resuscitationList.first;

  List<String> get hospitalizationList {
    return [
      "Not specified",
      "No",
      "Yes",
      "I do want to be admitted to hospital, but only for symptom control which cannot be handled in the outpatient setting."
    ];
  }

  List<String> get intensiveTreatmentList {
    return [
      "Not specified",
      "No",
      "Yes",
      "I do want to be admitted to hospital, but only for symptom control which cannot be handled in the outpatient setting."
    ];
  }

  List<String> get resuscitationList {
    return [
      "Not specified",
      "No",
      "Yes",
      "I do want to be admitted to hospital, but only for symptom control which cannot be handled in the outpatient setting."
    ];
  }

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.generalTreatmentObjective);
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    context.go(Routes.futureSituations);
  }
}
