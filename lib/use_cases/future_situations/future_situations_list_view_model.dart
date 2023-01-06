import 'package:flutter/material.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';

class FutureSituationsListViewModel extends AspectListViewModel {
  FutureSituationsListViewModel();

  @override
  String get addAspectCallToActionText => l10n.addFutureSituationCallToAction;

  @override
  String get emptyAspectListsMessageText => l10n.futureSituationsEmptyText;

  @override
  AspectListChoice get aspectListChoice => (PatientDirective directive) => directive.futureSituationAspects;

  @override
  bool get showTreatmentOptions => true;

  @override
  bool get showAddAspectCallToAction => false;

  @override
  void onAddAspectCallToActionPressed(BuildContext context) {}

  @override
  String get removeAspectConfirmationCancel => l10n.removeFutureAspectConfirmationCancel;

  @override
  String get removeAspectConfirmationRemove => l10n.removeFutureAspectConfirmationRemove;
}
