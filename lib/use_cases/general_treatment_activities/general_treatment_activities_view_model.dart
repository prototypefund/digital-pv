import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/treatment_goal.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/treatment_activities/treatment_activities_selection_view_model.dart';

class TreatmentActivitiesViewModel extends CreationProcessNavigationViewModel {
  TreatmentActivitiesViewModel()
      : _patientDirectiveService = getIt.get(),
        _treatmentActivitiesSelectionViewModel = TreatmentActivitiesSelectionViewModel(
            hospitalizationSelection:
                getIt.get<PatientDirectiveService>().currentPatientDirective.generalHospitalizationPreference,
            resuscitationSelection:
                getIt.get<PatientDirectiveService>().currentPatientDirective.generalResuscitationPreference,
            intensiveTreatmentSelection:
                getIt.get<PatientDirectiveService>().currentPatientDirective.generalIntensiveTreatmentPreference) {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChange);
    _treatmentActivitiesSelectionViewModel.addListener(_reactToTreatmentActivitySelection);
  }

  final PatientDirectiveService _patientDirectiveService;

  final TreatmentActivitiesSelectionViewModel _treatmentActivitiesSelectionViewModel;

  String get addTreatmentActivitiesTitle => l10n.addTreatmentActivitiesTitle;

  String get addTreatmentActivitiesExplanation => l10n.addTreatmentActivitiesExplanation(
      _patientDirectiveService.currentPatientDirective.treatmentGoal.localizedString(l10n));

  TreatmentActivitiesSelectionViewModel get treatmentActivitiesSelectionViewModel =>
      _treatmentActivitiesSelectionViewModel;

  void _reactToPatientDirectiveChange() {
    notifyListeners();
  }

  void _reactToTreatmentActivitySelection() {
    final PatientDirective currentDirective = _patientDirectiveService.currentPatientDirective;
    currentDirective.generalHospitalizationPreference = treatmentActivitiesSelectionViewModel.hospitalizationSelection;
    currentDirective.generalIntensiveTreatmentPreference =
        treatmentActivitiesSelectionViewModel.intensiveTreatmentSelection;
    currentDirective.generalResuscitationPreference = treatmentActivitiesSelectionViewModel.resuscitationSelection;

    _patientDirectiveService.currentPatientDirective = currentDirective;
  }

  @override
  void dispose() {
    super.dispose();
    treatmentActivitiesSelectionViewModel.dispose();
  }

  @override
  void onBackButtonPressed(BuildContext context) {
    context.go(Routes.generalTreatmentObjective);
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    context.go(Routes.futureSituations);
  }
}
