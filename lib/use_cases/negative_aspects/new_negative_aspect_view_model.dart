import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/view_components/aspect_examples/aspect_examples_model.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect_view_model.dart';

class NewNegativeAspectViewModel extends NewAspectViewModel<Aspect> {
  @override
  String get addAspectActionText => l10n.addNegativeAspectCallToAction;

  @override
  String get addAspectExplanation => l10n.addNegativeAspectExplanation;

  @override
  String get addAspectTextfieldHint => l10n.addNegativeAspectTextFieldHint;

  @override
  String get addAspectTitle => l10n.addNegativeAspect;

  @override
  AspectListChoice<Aspect> get aspectListChoice => (PatientDirective directive) => directive.negativeAspects;

  @override
  String get examplesText => l10n.examples;

  @override
  List<Group> get examples {
    return [
      Group(title: l10n.negativeAspectsGroupPain, children: [
        Item(title: l10n.negativeAspectExampleBackPain),
      ]),
      Group(title: l10n.negativeAspectsGroupFamily, children: [
        Item(title: l10n.negativeAspectDeathOfPartner),
      ]),
      Group(title: l10n.negativeAspectsGroupLife, children: [
        Item(title: l10n.negativeAspectExampleFinancialSituation),
      ])
    ];
  }

  @override
  Aspect createNewAspect({required String name, required Weight weight}) {
    return Aspect(name: name, weight: weight);
  }
}
