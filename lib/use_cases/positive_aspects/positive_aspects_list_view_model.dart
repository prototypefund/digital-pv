import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';

class PositiveAspectsListViewModel extends AspectListViewModel {
  PositiveAspectsListViewModel();

  @override
  String get addAspectCallToActionText => l10n.addPositiveAspectCallToAction;

  @override
  String get emptyAspectListsMessageText => l10n.positiveAspectsEmptyText;

  @override
  AspectListChoice get aspectListChoice => (PatientDirective directive) => directive.positiveAspects;

  @override
  bool get showTreatmentOptions => false;

  @override
  bool get showAddAspectCallToAction => true;

  @override
  void onAddAspectCallToActionPressed(BuildContext context) {
    context.push(Routes.addPositiveAspect);
  }

  @override
  String get removeAspectConfirmationCancel => l10n.removePositiveAspectConfirmationCancel;

  @override
  String get removeAspectConfirmationRemove => l10n.removePositiveAspectConfirmationRemove;

  @override
  String getRemoveAspectConfirmationQuestionLocalization(String aspectName) {
    return l10n.removePositiveAspectConfirmationQuestion(aspectName);
  }
}
