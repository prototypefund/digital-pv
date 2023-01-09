import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/treatment_activity.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/treatment_activities/treatment_activities_selection_view_model.dart';

class GeneralTreatmentActivitiesSelectionViewModel extends TreatmentActivitiesSelectionViewModel {
  GeneralTreatmentActivitiesSelectionViewModel() : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChanges);
  }

  final PatientDirectiveService _patientDirectiveService;

  @override
  TreatmentActivityChoice get hospitalizationSelection {
    return _patientDirectiveService.currentPatientDirective.generalHospitalizationPreference;
  }

  @override
  TreatmentActivityChoice get intensiveTreatmentSelection {
    return _patientDirectiveService.currentPatientDirective.generalIntensiveTreatmentPreference;
  }

  @override
  TreatmentActivityChoice get resuscitationSelection {
    return _patientDirectiveService.currentPatientDirective.generalResuscitationPreference;
  }

  @override
  set hospitalizationSelection(TreatmentActivityChoice newValue) {
    _patientDirectiveService.currentPatientDirective = _patientDirectiveService.currentPatientDirective
      ..generalHospitalizationPreference = newValue;
  }

  @override
  set intensiveTreatmentSelection(TreatmentActivityChoice newValue) {
    _patientDirectiveService.currentPatientDirective = _patientDirectiveService.currentPatientDirective
      ..generalIntensiveTreatmentPreference = newValue;
  }

  @override
  set resuscitationSelection(TreatmentActivityChoice newValue) {
    _patientDirectiveService.currentPatientDirective = _patientDirectiveService.currentPatientDirective
      ..generalResuscitationPreference = newValue;
  }

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChanges);
  }

  void _reactToPatientDirectiveChanges() {
    notifyListeners();
  }
}
