import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/view_components/aspect_examples/aspect_examples_model.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect_view_model.dart';

class NewFutureSituationViewModel extends NewAspectViewModel {
  @override
  String get addAspectActionText => l10n.addFutureSituationCallToAction;

  @override
  String get addAspectExplanation => l10n.addPositiveAspectExplanation;

  @override
  String get addAspectTextfieldHint => l10n.addFutureSituationAspectTextfieldHint;

  @override
  String get addAspectTitle => l10n.addFutureSituationAspect;

  @override
  AspectListChoice get aspectListChoice => (PatientDirective directive) => directive.futureSituationAspects;

  @override
  String get examplesText => l10n.examples;

  @override
  List<Group> get examples {
    return [
      Group(title: l10n.futureSituationsGroupTitleSevereImpairement, children: [
        Item(
            title: l10n.futureSituationsExampleIntensiveCare,
            description: l10n.futureSituationsExampleIntensiveCareDescription),
        Item(
            title: l10n.futureSituationsExampleSevereImpairement,
            description: l10n.futureSituationsExampleSevereImpairementDescription),
        Item(
            title: l10n.futureSituationsExampleIntellectualImpairment,
            description: l10n.futureSituationsExampleIntellectualImpairmentDescription)
      ]),
      Group(title: l10n.futureSituationsGroupTitleUncertainCondition, children: [
        Item(
            title: l10n.futureSituationsExampleWakingComa,
            description: l10n.futureSituationsExampleWakingComaDescription)
      ]),
      Group(title: l10n.futureSituationsGroupDeathInescapable, children: [
        Item(title: l10n.futureSituationsExampleDeadlyDisease),
        Item(title: l10n.futureSituationsExampleProcessOfDying),
      ]),
    ];
  }
}
