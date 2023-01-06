import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/treatment_activity.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/treatment_activities/treatment_activities_selection_view_model.dart';

class FutureSituationTreatmentActivitiesSelectionViewModel extends TreatmentActivitiesSelectionViewModel {
  FutureSituationTreatmentActivitiesSelectionViewModel({required this.futureSituation})
      : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChanges);
  }

  final FutureSituation futureSituation;

  final PatientDirectiveService _patientDirectiveService;

  @override
  TreatmentActivityChoice get hospitalizationSelection {
    return _aspectFromPatientDirective().hospitalizationPreference;
  }

  @override
  TreatmentActivityChoice get intensiveTreatmentSelection {
    return _aspectFromPatientDirective().intensiveTreatmentPreference;
  }

  @override
  TreatmentActivityChoice get resuscitationSelection {
    return _aspectFromPatientDirective().resuscitationPreference;
  }

  @override
  set hospitalizationSelection(TreatmentActivityChoice newValue) {
    _changeFutureSituationInDirective((aspect) => aspect.hospitalizationPreference = newValue);
  }

  @override
  set intensiveTreatmentSelection(TreatmentActivityChoice newValue) {
    _changeFutureSituationInDirective((aspect) => aspect.intensiveTreatmentPreference = newValue);
  }

  @override
  set resuscitationSelection(TreatmentActivityChoice newValue) {
    _changeFutureSituationInDirective((aspect) => aspect.resuscitationPreference = newValue);
  }

  void _changeFutureSituationInDirective(Function(FutureSituation futureSituation) manipulation) {
    final PatientDirective currentDirective = _patientDirectiveService.currentPatientDirective;

    final FutureSituation futureSituationFromService =
        currentDirective.futureSituationAspects.firstWhere((element) => element == futureSituation);
    manipulation(futureSituationFromService);
    _patientDirectiveService.currentPatientDirective = currentDirective;
  }

  FutureSituation _aspectFromPatientDirective() =>
      _patientDirectiveService.currentPatientDirective.futureSituationAspects
          .firstWhere((element) => element == futureSituation);

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChanges);
  }

  void _reactToPatientDirectiveChanges() {
    notifyListeners();
  }
}
