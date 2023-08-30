import 'package:flutter/material.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';

class NegativeAspectsListViewModel extends AspectListViewModel<Aspect> {
  NegativeAspectsListViewModel({required super.focusAspect, required super.scrollController}) {
    _contentService.addListener(notifyListeners);
  }

  final ContentService _contentService = getIt.get();

  @override
  String get emptyAspectListsMessageText => _contentService.negativeAspectsPage.aspectListWidget.emptyListMessage;

  @override
  AspectListChoice<Aspect> get aspectListChoice => (PatientDirective directive) => directive.negativeAspects;

  @override
  bool get showTreatmentOptions => false;

  @override
  String get removeAspectConfirmationCancel =>
      _contentService.negativeAspectsPage.aspectListWidget.deleteConfirmationCancel;

  @override
  String get removeAspectConfirmationRemove =>
      _contentService.negativeAspectsPage.aspectListWidget.deleteConfirmationConfirm;

  @override
  String getRemoveAspectConfirmationQuestionLocalization(String aspectName) {
    return _contentService.negativeAspectsPage.aspectListWidget.deleteConfirmationQuestion;
  }

  @override
  void onAddAspectCallToActionPressed(BuildContext context) {}

  @override
  void dispose() {
    super.dispose();
    _contentService.removeListener(notifyListeners);
  }

  @override
  String get aspectSignificanceHighLabel => _contentService.negativeAspectsPage.aspectListWidget.highSignificanceLabel;

  @override
  String get aspectsSignificanceLowLabel => _contentService.negativeAspectsPage.aspectListWidget.lowSignificanceLabel;

  @override
  bool get isSimulateAspectEnabled => false;

  @override
  String get simulateLabel => 'No label';
}
