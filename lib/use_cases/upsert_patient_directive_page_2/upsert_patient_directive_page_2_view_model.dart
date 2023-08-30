import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/logging.dart';

class UpsertPatientDirectivePage2ViewModel extends CreationProcessNavigationViewModel with Logging {
  final ContentService _contentService;
  bool _createPatientDirectiveIsSelected = false;
  bool _editPatientDirectiveIsSelected = false;
  @override
  bool get showAppBar => false;

  UpsertPatientDirectivePage2ViewModel() : _contentService = getIt.get() {
    _contentService.addListener(notifyListeners);
  }

  @override
  void dispose() {
    super.dispose();
    _contentService.removeListener(notifyListeners);
  }

  String get subtitle => "Patientenverfügung erstellen";
  String get title => "Wie möchten Sie vorgehen?";
  String get continueButtonTitle => "weiter";
  String get createWithAccountPatientDirectiveTitle => "Patientenverfügung mit Konto erstellen";
  String get createWithAccountPatientDirectiveDescription =>
      "Sie legen ein **Nutzerkonto** für Ihre Patientenverfügung an. Mit einem Konto werde viele **Services** wie Erinnerungsfunktionen oder Freigaben (d.h, dass z.B. Ärzt:innen oder Verwandte die Patientenverfügung einsehen können) erst möglich. Ihre Daten sind im Konto **jederzeit** für Sie verfügbar. Wir schützen Ihre Daten mit neuesten Techniken, da wir uns bewusst sind, dass sie besonders **schützenswert** sind.";
  String get createWithoutAccountPatientDirectiveDescription =>
      "Sie erstellen Ihre Patientenverfügung **ohne Konto** und können die Daten lokal **auf Ihrem Gerät** speichern, wieder aufrufen und weiter bearbeiten. **Services** wie Erinnerungsfunktionen oder Freigaben sind **nicht möglich.**";
  String get editPatientDirectiveDescription => "";
  String get createWithoutAccountPatientDirectiveTitle => "Patientenverfügung ohne Konto erstellen";

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
