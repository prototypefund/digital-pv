import 'package:pd_app/general/dynamic_content/content_definitions/aspects_example.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect_view_model.dart';

class TreatmentActivitySelectionViewModel extends NewFutureSituationViewModel {
  TreatmentActivitySelectionViewModel({required super.autofocus});

  @override
  String get descriptionOne => "### Nehmen Sie sich **Zeit**.  ";

  @override
  String get explanationOne =>
      "Nehmen Sie sich die **Zeit, die Sie benötigen**. Sie können unterbrechen, den aktuellen Stand speichern, um z.B. mit Angehörigen, Freunden oder Ärzt:innen zu sprechen und später an diesem Punkt weiterzumachen.";

  String get descriptionTwo => "### Sehen Sie den **Effekt**.";
  String get explanationTwo => """
Nachdem Sie eine Was wäre wenn?-Situation beschrieben haben, können Sie sich den Effekt auf Ihr Behandlungsziel zeigen lassen. Drücken Sie dazu den Button "Eintritt simulieren".
""";
}

class NewFutureSituationViewModel extends NewAspectViewModel<FutureSituation> {
  NewFutureSituationViewModel({required super.autofocus, super.selectedAspect})
      : _contentService = getIt.get(),
        _patientDirectiveService = getIt.get();

  String get simulateLabel => _contentService.futureSituationsPage.aspectListWidget.simulateAspectLabel ?? '';

  final PatientDirectiveService _patientDirectiveService;

  String get descriptionOne => "### Welche Bedeutung hat diese Situation für Sie?";

  String get explanationOne => """
Mit dem Slider können Sie einstellen, welche **Bedeutung**
diese Was wäre wenn-Situation für **Sie hat**. Die Bedeutung
hat direkten **Einfluss auf Ihr Behandlungsziel**. Dabei gilt:
Je höher die Bedeutung, desto größer der Einfluss. Sie können den Einfluss Ihrer Was wäre wenn-Situation auf Ihr Behandlungs- ziel jederzeit simulieren lassen.
""";
  @override
  String get selectedItemContent => """
#### Was wäre wenn-Situation und zugehörige Maßnahmen
### ${selectedAspect?.name}
""";

  @override
  String get more => "Mehr";

  @override
  String get title => "#### Bedeutung";

  @override
  String get aspectNameLabel => "Wie soll Ihre Situation lauten?";
  @override
  String get aspectNameHint => "Wachkoma";
  @override
  String get aspectDetailLabel => "Hier können Sie Details beschreiben (optional)";

  @override
  String get sliderLabel => "Welche Bedeutung hat die Situation für Sie?";
  @override
  String get lowWeightLabel => "niedrig";
  @override
  String get middleWeightLabel => "mittel";
  @override
  String get highWeightLabel => "hoch";

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
  FutureSituation createNewAspect({required String name, required Weight weight, String? description}) {
    return FutureSituation(
      name: name,
      weight: weight,
      treatmentActivitiyPreferences: [],
    );
  }

  void toggleSimulation({required FutureSituation aspect}) {
    logger.d('toggle simulation property of future situation $aspect');

    final currentDirective = _patientDirectiveService.currentPatientDirective;
    final index = currentDirective.futureSituationAspects.indexWhere((element) => element == aspect);

    final updatedFutureSituations = List<FutureSituation>.from(currentDirective.futureSituationAspects);
    updatedFutureSituations[index] = aspect.copyWith(simulateAspect: !aspect.simulateAspect);

    final updatedDirective = currentDirective.copyWith(futureSituationAspects: updatedFutureSituations);
    _patientDirectiveService.currentPatientDirective = updatedDirective;
  }

  @override
  List<AspectsExample> get aspectExamples => _contentService.futureSituationsExamples;

  @override
  String get examplesTitle => _contentService.futureSituationsPage.examplesTitle;

  @override
  String get aspectSignificanceHighLabel => _contentService.futureSituationsPage.addAspectWidget.highSignificanceLabel;

  @override
  String get aspectsSignificanceLowLabel => _contentService.futureSituationsPage.addAspectWidget.lowSignificanceLabel;
}
