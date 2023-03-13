import 'package:pd_app/general/dynamic_content/content_definitions/aspects_example.dart';
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
  String get addAspectActionText => _contentService.futureSituationsPage.addAspectWidget.addAspectActionLabel;

  @override
  String get addAspectTextfieldHint => _contentService.futureSituationsPage.addAspectWidget.emptyTextFieldHint;

  @override
  AspectListChoice<FutureSituation> get aspectListChoice =>
      (PatientDirective directive) => directive.futureSituationAspects;

  @override
  String get examplesText => _contentService.futureSituationsPage.examplesTitle;

  @override
  FutureSituation createNewAspect({required String name, required Weight weight}) {
    return FutureSituation(name: name, weight: weight);
  }

  @override
  List<AspectsExample> get aspectExamples => _contentService.futureSituationsExamples;
}
