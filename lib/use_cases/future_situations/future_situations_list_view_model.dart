import 'package:flutter/material.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';

class FutureSituationsListViewModel extends AspectListViewModel<FutureSituation> {
  FutureSituationsListViewModel() {
    _contentService.addListener(notifyListeners);
  }

  final ContentService _contentService = getIt.get();

  final PatientDirectiveService _patientDirectiveService = getIt.get();

  @override
  String get emptyAspectListsMessageText => _contentService.futureSituationsPage.aspectListWidget.emptyListMessage;

  @override
  AspectListChoice<FutureSituation> get aspectListChoice =>
      (PatientDirective directive) => directive.futureSituationAspects;

  @override
  bool get showTreatmentOptions => true;

  @override
  void onAddAspectCallToActionPressed(BuildContext context) {}

  @override
  String get removeAspectConfirmationCancel =>
      _contentService.futureSituationsPage.aspectListWidget.deleteConfirmationCancel;

  @override
  String get removeAspectConfirmationRemove =>
      _contentService.futureSituationsPage.aspectListWidget.deleteConfirmationConfirm;

  @override
  String getRemoveAspectConfirmationQuestionLocalization(String aspectName) {
    return _contentService.futureSituationsPage.aspectListWidget.deleteConfirmationQuestion;
  }

  @override
  void dispose() {
    super.dispose();
    _contentService.removeListener(notifyListeners);
  }

  @override
  String get aspectSignificanceHighLabel => _contentService.futureSituationsPage.aspectListWidget.highSignificanceLabel;

  @override
  String get aspectsSignificanceLowLabel => _contentService.futureSituationsPage.aspectListWidget.lowSignificanceLabel;

  @override
  bool get isSimulateAspectEnabled => true;

  @override
  String get simulateLabel => _contentService.futureSituationsPage.aspectListWidget.simulateAspectLabel ?? '';

  @override
  void toggleSimulation({required FutureSituation aspect}) {
    logger.d('toggle simulation property of future situation $aspect');

    final currentDirective = _patientDirectiveService.currentPatientDirective;
    final index = currentDirective.futureSituationAspects.indexWhere((element) => element == aspect);
    final situationFromDirective = currentDirective.futureSituationAspects[index];

    final updatedSituation = situationFromDirective.copyWith(simulateAspect: !situationFromDirective.simulateAspect);

    final updatedFutureSituations = List<FutureSituation>.from(currentDirective.futureSituationAspects);
    updatedFutureSituations[index] = updatedSituation;

    final updatedDirective = currentDirective.copyWith(futureSituationAspects: updatedFutureSituations);
    _patientDirectiveService.currentPatientDirective = updatedDirective;
  }
}
