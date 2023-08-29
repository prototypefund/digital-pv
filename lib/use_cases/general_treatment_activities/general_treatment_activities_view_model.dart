import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/treatment_activities_page.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';

enum NavigationSubStep { selectType, description, select, edit, complete }

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

  NavigationSubStep _navigationStep = NavigationSubStep.selectType;
  NavigationSubStep get navigationStep => _navigationStep;

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChange);
    _contentService.removeListener(notifyListeners);
  }

  bool get isCurative => _patientDirectiveService.currentPatientDirective.generalTreatmentGoal.value == 1;

  double get currentAspectScore {
    return (_patientDirectiveService.currentPatientDirective.currentAspectsScore * -50) + 50;
  }

  String get subtitle => "### Maßnahmen und Situationen beschreiben";
  String get title =>
      isCurative ? "## Sie wünschen eine kurative Behandlung." : "## Sie wünschen eine palliative Behandlung.";
  String get subtopic =>
      "#### Jetzt können Sie Situationen beschreiben, in denen spezielle Maßnahmen getroffen werden sollen";
  String get visualizationPositiveTitle => "Positive Aspekte";
  String get visualizationNegativeTitle => "Negative Aspekte";
  String get visualizationTitle => """
### Mein Behandlungsziel
falls ich nicht entscheidungsfähig bin
""";

  String get situationsTitle => "Situationen";
  String get situationsDescription =>
      "Wählen Sie Situationen, die Ihnen wichtig sind, weil Sie besondere Maßnahmen festlegen wollen. Das kann beispielsweise eine fortschreitende Demenz sein. Diese Situationen nennen wir Was wäre wenn?-Situationen. Sie gelten für den Fall, dass Sie nicht einwilligungsfähig sind. [[Weitere Beispiele.]]()";
  String get treatmentActivitiesTitle => "Maßnahmen";
  String get treatmentActivitiesDescription =>
      "Legen Sie besondere Maßnahmen für Situationen fest, die Ihnen wichtig sind. Möchten Sie z.B. bei forschreitender Demenz intensiv- medizinisch behandelt werden? Sie können festlegen, in welcher Situation Sie lebensverländernden Maßnahmen wünschen oder ablehnen. [[Mehr Informationen.]]()";

  bool _situationSelected = false;
  bool _treatmentActivitiesSelected = false;

  bool get situationSelected => _situationSelected;
  set situationSelected(bool value) {
    _situationSelected = value;
    _treatmentActivitiesSelected = !value;
    notifyListeners();
  }

  bool get treatmentActivitiesSelected => _treatmentActivitiesSelected;
  set treatmentActivitiesSelected(bool value) {
    _situationSelected = !value;
    _treatmentActivitiesSelected = value;
    notifyListeners();
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    if (_situationSelected) {
      context.go(Routes.futureSituations.path);
    } else {
      _navigationStep = NavigationSubStep.select;
    }
  }

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => false;

  @override
  bool get showTreatmentGoalInVisualization => true;

  TreatmentActivitiesPage get pageContent => _contentService.treatmentActivitiesPage;
}
