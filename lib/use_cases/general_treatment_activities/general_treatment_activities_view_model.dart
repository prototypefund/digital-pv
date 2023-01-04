import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/treatment_goal.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/treatment_activities/treatment_activities_selection_view_model.dart';

class TreatmentActivitiesViewModel extends CreationProcessNavigationViewModel {
  TreatmentActivitiesViewModel() : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChange);
  }

  final PatientDirectiveService _patientDirectiveService;

  String get addTreatmentActivitiesTitle => l10n.addTreatmentActivitiesTitle;

  String get addTreatmentActivitiesExplanation => l10n.addTreatmentActivitiesExplanation(
      _patientDirectiveService.currentPatientDirective.treatmentGoal.localizedString(l10n));

  final TreatmentActivitiesSelectionViewModel treatmentActivitiesSelectionViewModel =
      TreatmentActivitiesSelectionViewModel();

  void _reactToPatientDirectiveChange() {
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    treatmentActivitiesSelectionViewModel.dispose();
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
