import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/model/treatment_activity.dart';
import 'package:pd_app/general/navigation/routes.dart';

class TreatmentActivitiesViewModel extends CreationProcessNavigationViewModel {
  String get addTreatmentActivitiesTitle => l10n.addTreatmentActivitiesTitle;

  String get addTreatmentActivitiesExplanation => l10n.addTreatmentActivitiesExplanation;

  String get addTreatmentActivitiesSubHeadline => l10n.addTreatmentActivitiesSubHeadline;

  String get addTreatmentActivitiesHospitalAdmission => l10n.addTreatmentActivitiesHospitalAdmission;

  String get addTreatmentActivitiesIntensiveTreatment => l10n.addTreatmentActivitiesIntensiveTreatment;

  String get addTreatmentActivitiesResuscitation => l10n.addTreatmentActivitiesResuscitation;

  late TreatmentActivity? hospitalizationSelection = hospitalizationList.first;
  late TreatmentActivity? intensiveTreatmentSelection = intensiveTreatmentList.first;
  late TreatmentActivity? resuscitationSelection = resuscitationList.first;

  List<TreatmentActivity> get hospitalizationList {
    return [
      TreatmentActivity.notSpecified,
      TreatmentActivity.no,
      TreatmentActivity.yes,
      TreatmentActivity.symptomControl
    ];
  }

  List<TreatmentActivity> get intensiveTreatmentList {
    return [TreatmentActivity.notSpecified, TreatmentActivity.no, TreatmentActivity.yes];
  }

  List<TreatmentActivity> get resuscitationList {
    return [TreatmentActivity.notSpecified, TreatmentActivity.no, TreatmentActivity.yes];
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
