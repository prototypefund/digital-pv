import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/logging.dart';

class UpsertPatientDirectivePage1ViewModel extends CreationProcessNavigationViewModel with Logging {
  final ContentService _contentService;
  bool _createPatientDirectiveIsSelected = false;
  bool _editPatientDirectiveIsSelected = false;
  @override
  bool get showAppBar => false;

  @override
  bool get backButtonVisible => false;

  UpsertPatientDirectivePage1ViewModel() : _contentService = getIt.get() {
    _contentService.addListener(notifyListeners);
  }

  @override
  void dispose() {
    super.dispose();
    _contentService.removeListener(notifyListeners);
  }

  String get subtitle => "Patientenverfügung erstellen";
  String get title => "Legen wir los.";
  String get continueButtonTitle => "weiter";
  String get createPatientDirectiveTitle => "Patientenverfügung neu erstellen";
  String get createPatientDirectiveDescription => "";
  String get createPatientDirectiveAssetPath => "assets/images/create.svg";
  String get editPatientDirectiveDescription => "";
  String get editPatientDirectiveTitle => "Patientenverfügung bearbeiten";
  String get editPatientDirectiveAssetPath => "assets/images/update.svg";

  bool get createPatientDirectiveIsSelected => _createPatientDirectiveIsSelected;
  set createPatientDirectiveIsSelected(bool value) {
    _createPatientDirectiveIsSelected = value;
    _editPatientDirectiveIsSelected = !value;
    notifyListeners();
  }

  bool get editPatientDirectiveIsSelected => _editPatientDirectiveIsSelected;
  set editPatientDirectiveIsSelected(bool value) {
    _editPatientDirectiveIsSelected = value;
    _createPatientDirectiveIsSelected = !value;
    notifyListeners();
  }

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => false;

  @override
  bool get showTreatmentGoalInVisualization => false;
}
