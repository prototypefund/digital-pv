import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/logging.dart';

class UpsertPatientDirectivePage3ViewModel extends CreationProcessNavigationViewModel with Logging {
  final ContentService _contentService;

  UpsertPatientDirectivePage3ViewModel() : _contentService = getIt.get() {
    _contentService.addListener(notifyListeners);
  }

  @override
  void dispose() {
    super.dispose();
    _contentService.removeListener(notifyListeners);
  }

  String get subtitle => "Patientenverfügung erstellen";
  String get title => "Schön, dass Sie hier sind!";
  String get continueButtonTitle => "weiter";
  String get cardOneText => "Für Sie selbst und Ihre Lieben";
  String get cardOneDescription =>
      "Sie nehmen sich einem der wichtigsten Themen in Ihrem Leben an. Sie sorgen für sich selbst vor und entlasten Ihre Angehörige, indem Sie Ihre Wünsche festlegen.";
  String get cardTwoDescription =>
      "Mit einer Patientenverfügung legene Sie für den Fall Ihrer Entscheidungs- unfähigkeit fest, wie Sie in bestimmen Situationen oder grundsätzlich medizinisch behandelt werden möchten. Wir bringen Sie komfortabel an Ihr Ziel: Eine rechtskräftige Patientenverfügung, die genau Ihren Wünschen entspricht.";
  String get cardTwoText => "Ihr Ziel";

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => false;

  @override
  bool get showTreatmentGoalInVisualization => false;
}
