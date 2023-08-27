import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/aspects_example.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect_view_model.dart';

class NewPositiveAspectViewModel extends NewAspectViewModel<Aspect> {
  NewPositiveAspectViewModel({required super.autofocus}) : _contentService = getIt.get() {
    _contentService.addListener(notifyListeners);
  }

  String get nextButtonText => "Bestätigen";

  @override
  String get selectedItemContent => """
### Eigener Aspekt 
Positiver Aspekt des aktuellen Lebens
## Genesung""";
  @override
  String get more => "Mehr";
  @override
  String get title => "### Bitte beschreiben Sie Ihren positiven Aspekt";

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

  final ContentService _contentService;

  @override
  String get addAspectActionText => _contentService.positiveAspectsPage.addAspectWidget.addAspectActionLabel;

  @override
  String get addAspectTextfieldHint => _contentService.positiveAspectsPage.addAspectWidget.emptyTextFieldHint;

  @override
  AspectListChoice<Aspect> get aspectListChoice => (PatientDirective directive) => directive.positiveAspects;

  @override
  String get examplesText => _contentService.positiveAspectsPage.examplesTitle;

  @override
  void onAddAspectActionPressed(BuildContext context) {
    super.onAddAspectActionPressed(context);
    context.go(Routes.positiveAspects.path);
  }

  @override
  Aspect createNewAspect({required String name, required Weight weight, String? description}) {
    return Aspect(name: name, weight: weight, description: description);
  }

  @override
  List<AspectsExample> get aspectExamples => _contentService.positiveAspectsExamples;

  @override
  void dispose() {
    super.dispose();
    _contentService.removeListener(notifyListeners);
  }

  @override
  String get examplesTitle => _contentService.positiveAspectsPage.examplesTitle;

  @override
  String get aspectSignificanceHighLabel => _contentService.positiveAspectsPage.addAspectWidget.highSignificanceLabel;

  @override
  String get aspectsSignificanceLowLabel => _contentService.positiveAspectsPage.addAspectWidget.lowSignificanceLabel;
}
