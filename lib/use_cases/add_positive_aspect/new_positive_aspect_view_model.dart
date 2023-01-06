import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/view_components/aspect_examples/aspect_examples_model.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect_view_model.dart';

class NewPositiveAspectViewModel extends NewAspectViewModel<Aspect> {
  @override
  String get addAspectActionText => l10n.addPositiveAspectCallToAction;

  @override
  String get addAspectExplanation => l10n.addPositiveAspectExplanation;

  @override
  String get addAspectTextfieldHint => l10n.addPositiveAspectTextFieldHint;

  @override
  String get addAspectTitle => l10n.addPositiveAspectTitle;

  @override
  AspectListChoice<Aspect> get aspectListChoice => (PatientDirective directive) => directive.positiveAspects;

  @override
  String get examplesText => l10n.examples;

  @override
  void onAddAspectActionPressed(BuildContext context) {
    super.onAddAspectActionPressed(context);
    context.go(Routes.positiveAspects);
  }

  @override
  List<Group> get examples {
    return [
      Group(title: l10n.positiveAspectsGroupFamily, children: [
        Item(title: l10n.spendTimeWithFamily),
        Item(title: l10n.pet),
      ]),
      Group(title: l10n.positiveAspectsGroupLeisure, children: [
        Item(title: l10n.personalContacts),
        Item(title: l10n.myHome),
        Item(title: l10n.travelling),
      ]),
      Group(title: l10n.positiveAspectsGroupWork, children: [
        Item(title: l10n.myWork),
        Item(title: l10n.writingBooks),
      ]),
      Group(title: l10n.positiveAspectsGroupSport, children: [
        Item(title: l10n.jogging),
        Item(title: l10n.ridingTheBike),
      ]),
    ];
  }

  @override
  Aspect createNewAspect({required String name, required Weight weight}) {
    return Aspect(name: name, weight: weight);
  }
}
