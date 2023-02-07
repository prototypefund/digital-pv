import 'package:pd_app/general/dynamic_content/aspects_example.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect_view_model.dart';

class NewFutureSituationViewModel extends NewAspectViewModel<FutureSituation> {
  NewFutureSituationViewModel() : _contentService = getIt.get();

  final ContentService _contentService;

  @override
  String get addAspectActionText => l10n.addFutureSituationCallToAction;

  @override
  String get addAspectExplanation => l10n.addPositiveAspectExplanation;

  @override
  String get addAspectTextfieldHint => l10n.addFutureSituationAspectTextfieldHint;

  @override
  String get addAspectTitle => l10n.addFutureSituationAspect;

  @override
  AspectListChoice<FutureSituation> get aspectListChoice =>
      (PatientDirective directive) => directive.futureSituationAspects;

  @override
  String get examplesText => l10n.examples;

  @override
  FutureSituation createNewAspect({required String name, required Weight weight}) {
    return FutureSituation(name: name, weight: weight);
  }

  @override
  List<AspectsExample> get aspectExamples => _contentService.futureSituationsExamples;
}
