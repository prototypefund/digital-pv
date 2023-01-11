import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/logging.dart';

class EvaluateCurrentAspectsViewModel extends CreationProcessNavigationViewModel with Logging {
  EvaluateCurrentAspectsViewModel() : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChanges);
  }

  final PatientDirectiveService _patientDirectiveService;

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.negativeAspects);
  }

  @override
  bool get nextButtonEnabled => true; // TODO disable an adapt tests

  String get headline => l10n.evaluateCurrentAspectHeadline;

  String get summary {
    if (_patientDirectiveService.currentPatientDirective.currentAspectsScore >= 0) {
      return l10n.evaluateCurrentAspectsSummaryPositive;
    } else {
      return l10n.evaluateCurrentAspectsSummaryNegative;
    }
  }

  String get confirmEvaluationQuestion => l10n.evaluateCurrentAspectsConfirmationQuestion;

  String get confirmEvaluation => l10n.evaluateCurrentAspectsConfirm;

  String get changeAspectsIfNoMatchCallToAction => l10n.evaluateCurrentAspectsChangeAspectsIfNotMatching;

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChanges);
  }

  void _reactToPatientDirectiveChanges() {
    notifyListeners();
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    context.go(Routes.generalTreatmentObjective); // TODO remove an adapt tests
  }

  void onConfirmPressed(BuildContext context) {
    context.go(Routes.generalTreatmentObjective);
  }

  @override
  bool get showAspectVisualization => false;
}
