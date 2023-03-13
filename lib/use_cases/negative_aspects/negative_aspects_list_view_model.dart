import 'package:flutter/material.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';

class NegativeAspectsListViewModel extends AspectListViewModel<Aspect> {
  NegativeAspectsListViewModel();

  @override
  String get emptyAspectListsMessageText => l10n.negativeAspectsEmptyText;

  @override
  AspectListChoice<Aspect> get aspectListChoice => (PatientDirective directive) => directive.negativeAspects;

  @override
  bool get showTreatmentOptions => false;

  @override
  String get removeAspectConfirmationCancel => l10n.removeNegativeAspectConfirmationCancel;

  @override
  String get removeAspectConfirmationRemove => l10n.removeNegativeAspectConfirmationRemove;

  @override
  String getRemoveAspectConfirmationQuestionLocalization(String aspectName) {
    return l10n.removeNegativeAspectConfirmationQuestion(aspectName);
  }

  @override
  void onAddAspectCallToActionPressed(BuildContext context) {}
}
