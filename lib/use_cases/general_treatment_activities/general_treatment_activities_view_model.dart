import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/treatment_activities_page.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';

class GeneralTreatmentActivitiesViewModel extends CreationProcessNavigationViewModel {
  GeneralTreatmentActivitiesViewModel() : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChange);
    _contentService.addListener(notifyListeners);
  }

  final PatientDirectiveService _patientDirectiveService;

  final ContentService _contentService = getIt.get();

  void _reactToPatientDirectiveChange() {
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChange);
    _contentService.removeListener(notifyListeners);
  }

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.generalTreatmentObjective);
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    context.go(Routes.futureSituations);
  }

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => false;

  @override
  bool get showTreatmentGoalInVisualization => true;

  TreatmentActivitiesPage get pageContent => _contentService.treatmentActivitiesPage;
}
