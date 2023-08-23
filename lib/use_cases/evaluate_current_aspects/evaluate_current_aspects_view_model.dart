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
  bool get nextButtonEnabled => _expectationMatchSelected || _expectationMismatchSelected;

  bool get showPositiveSummary {
    return _patientDirectiveService.currentPatientDirective.currentAspectsScore >= 0;
  }

  String get subtitle => "Maßnahmen und Situationen beschreiben";
  String get title => "Lassen Sie uns zusammenfassen:";
  String get subtopic => showPositiveSummary
      ? "Insgesamt überwiegen die positiven Aspekte."
      : "Insgesamt überwiegen die negativen Aspekte.";
  String get visualizationPositiveTitle => "Positive Aspekte";
  String get visualizationNegativeTitle => "Negative Aspekte";
  String get visualizationTitle => "Gesamte Lebensqualität";

  @override
  String get nextButtonText => "Auswahl bestätigen";

  String get expectationMatch => "Ja";
  String get expectationMismatch => "Nein";

  String get expectationMatchDescription =>
      "Sehr schön. Dann können Sie die Beschreibung der Lebensqualität abschließen. ";
  String get expectationMismatchDescription =>
      "Sehen Sie sich Ihre Lebensqualität erneut an und nehmen Änderungen an den positiven oder negativen Aspekten vor, bis die Lebensqualität Ihrer Einschätzung entspricht.";

  bool _expectationMatchSelected = false;
  bool _expectationMismatchSelected = false;

  bool get expectationMatchSelected => _expectationMatchSelected;
  set expectationMatchSelected(bool value) {
    _expectationMatchSelected = value;
    _expectationMismatchSelected = !value;
    notifyListeners();
  }

  bool get expectationMismatchSelected => _expectationMismatchSelected;
  set expectationMismatchSelected(bool value) {
    _expectationMatchSelected = !value;
    _expectationMismatchSelected = value;
    notifyListeners();
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
