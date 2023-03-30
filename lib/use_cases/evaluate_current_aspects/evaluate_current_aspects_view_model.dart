import 'package:flutter/widgets.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/quality_of_life_page.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/logging.dart';

class EvaluateCurrentAspectsViewModel extends CreationProcessNavigationViewModel with Logging {
  EvaluateCurrentAspectsViewModel() : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChanges);
    _contentService.addListener(notifyListeners);
  }

  final PatientDirectiveService _patientDirectiveService;

  final ContentService _contentService = getIt.get();

  @override
  bool get nextButtonEnabled => false;

  bool get showPositiveSummary {
    return _patientDirectiveService.currentPatientDirective.currentAspectsScore >= 0;
  }

  QualityOfLifePage get pageContent => _contentService.qualityOfLifePage;

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChanges);
    _contentService.removeListener(notifyListeners);
  }

  void _reactToPatientDirectiveChanges() {
    notifyListeners();
  }

  void onConfirmPressed(BuildContext context) {
    onNextButtonPressed(context);
  }

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => false;

  @override
  bool get showTreatmentGoalInVisualization => false;
}
