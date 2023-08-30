// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/aspects_example.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/view_components/aspect_examples/aspect_examples_model.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect_view_model.dart';

class NewNegativeAspectViewModel extends NewAspectViewModel<Aspect> {
  NewNegativeAspectViewModel({required super.autofocus}) : _contentService = getIt.get();

  String get nextButtonText => "Bestätigen";

  @override
  String get selectedItemContent => """
#### Beispiel
 Negativer Aspekt des aktuellen Lebens

### ${selectedAspect!.name}
#### ${selectedAspect!.description ?? ""}
""";

  @override
  String get more => "Mehr";
  @override
  String get title => "### Bitte beschreiben Sie Ihren negativen Aspekt";

  @override
  String get aspectNameLabel => "Wie soll Ihr Aspekt heißen?";
  @override
  String get aspectNameHint => "Genesung";
  @override
  String get aspectDetailLabel => "Hier können Sie Details beschreiben (optional)";

  @override
  String get sliderLabel => "Welche Bedeutung hat der Aspekt für Sie?";

  @override
  String get lowWeightLabel => "niedrig";
  @override
  String get middleWeightLabel => "mittel";
  @override
  String get highWeightLabel => "hoch";

  @override
  void onAddAspectActionPressed(BuildContext context) {
    super.onAddAspectActionPressed(context);
    context.go(Routes.negativeAspects.path);
  }

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
  Aspect createNewAspect({required String name, required Weight weight, String? description}) {
    return Aspect(name: name, weight: weight, description: description);
  }

  @override
  List<AspectsExample> get aspectExamples => _contentService.negativeAspectsExamples;

  @override
  String get examplesTitle => _contentService.negativeAspectsPage.examplesTitle;

  @override
  String get aspectSignificanceHighLabel => _contentService.negativeAspectsPage.addAspectWidget.highSignificanceLabel;

  @override
  String get aspectsSignificanceLowLabel => _contentService.negativeAspectsPage.addAspectWidget.lowSignificanceLabel;
}
