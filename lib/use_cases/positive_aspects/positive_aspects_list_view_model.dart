import 'package:flutter/material.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';

class PositiveAspectsListViewModel extends AspectListViewModel<Aspect> {
  PositiveAspectsListViewModel({required super.focusAspect, required super.scrollController}) {
    _contentService.addListener(notifyListeners);
  }

  final ContentService _contentService = getIt.get();

  @override
  String get emptyAspectListsMessageText => _contentService.positiveAspectsPage.aspectListWidget.emptyListMessage;

  @override
  AspectListChoice<Aspect> get aspectListChoice => (PatientDirective directive) => directive.positiveAspects;

  @override
  bool get showTreatmentOptions => false;

  @override
  void onAddAspectCallToActionPressed(BuildContext context) {}

  @override
  String get removeAspectConfirmationCancel =>
      _contentService.positiveAspectsPage.aspectListWidget.deleteConfirmationCancel;

  @override
  String get removeAspectConfirmationRemove =>
      _contentService.positiveAspectsPage.aspectListWidget.deleteConfirmationConfirm;

  @override
  String getRemoveAspectConfirmationQuestionLocalization(String aspectName) {
    return _contentService.positiveAspectsPage.aspectListWidget.deleteConfirmationQuestion;
  }

  @override
  void dispose() {
    super.dispose();
    _contentService.removeListener(notifyListeners);
  }

  @override
  String get aspectSignificanceHighLabel => _contentService.positiveAspectsPage.aspectListWidget.highSignificanceLabel;

  @override
  String get aspectsSignificanceLowLabel => _contentService.positiveAspectsPage.aspectListWidget.lowSignificanceLabel;

  @override
  bool get isSimulateAspectEnabled => false;

  @override
  String get simulateLabel => 'No label';
}
