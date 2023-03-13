// ignore_for_file: unused_import

import 'package:pd_app/general/dynamic_content/content_definitions/aspects_example.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/view_components/aspect_examples/aspect_examples_model.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect_view_model.dart';

class NewNegativeAspectViewModel extends NewAspectViewModel<Aspect> {
  NewNegativeAspectViewModel() : _contentService = getIt.get();

  final ContentService _contentService;

  @override
  String get addAspectActionText => _contentService.negativeAspectsPage.addAspectWidget.addAspectActionLabel;

  @override
  String get addAspectTextfieldHint => _contentService.negativeAspectsPage.addAspectWidget.emptyTextFieldHint;

  @override
  AspectListChoice<Aspect> get aspectListChoice => (PatientDirective directive) => directive.negativeAspects;

  @override
  String get examplesText => _contentService.negativeAspectsPage.examplesTitle;

  @override
  Aspect createNewAspect({required String name, required Weight weight}) {
    return Aspect(name: name, weight: weight);
  }

  @override
  List<AspectsExample> get aspectExamples => _contentService.negativeAspectsExamples;
}
