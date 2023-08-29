import 'package:flutter/material.dart';
import 'package:pd_app/general/aspect_view_model/aspect_view_model.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/future_situations_page.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/future_situations/future_situations_list_view_model.dart';
import 'package:pd_app/use_cases/future_situations/new_future_situation_view_model.dart';

enum NavigationSubStep { description, select, edit, assignTreatmentActivity, complete }

class FutureSituationsViewModel extends CreationProcessNavigationViewModel with AspectViewModel, Logging {
  FutureSituationsViewModel({this.focusAspect})
      : newFutureSituationViewModel = NewFutureSituationViewModel(autofocus: focusAspect == null),
        treatmentActivititySelectionViewModel = TreatmentActivitySelectionViewModel(autofocus: focusAspect == null) {
    _futureSituationsListViewModel =
        FutureSituationsListViewModel(focusAspect: focusAspect, scrollController: scrollController);
    _futureSituationsListViewModel.addListener(_reactToAspectListChange);
    _contentService.addListener(notifyListeners);
  }

  NavigationSubStep _navigationStep = NavigationSubStep.description;
  NavigationSubStep get navigationStep => _navigationStep;

  String get subtitle => "### Maßnahmen und Situationen beschreiben";
  String get title => "## Meine Was wäre wenn-Situation.";
  String get subtopic => "#### Beschreiben Sie jetzt künftige Situationen und Maßnahmen, die Ihnen am Herzen liegen.";
  String get visualizationPositiveTitle => "Positive Aspekte";
  String get visualizationNegativeTitle => "Negative Aspekte";
  String get visualizationTitle => """
### Mein Behandlungsziel
falls ich nicht entscheidungsfähig bin
""";

  String get descriptionOne => "### Nehmen Sie sich **Zeit**.  ";

  String get explanationOne =>
      "Nehmen Sie sich die **Zeit, die Sie benötigen**. Sie können unterbrechen, den aktuellen Stand speichern, um z.B. mit Angehörigen, Freunden oder Ärzt:innen zu sprechen und später an diesem Punkt weiterzumachen.";

  String get descriptionTwo => "### Sehen Sie den **Effekt**.";
  String get explanationTwo => """
Nachdem Sie eine Was wäre wenn?-Situation beschrieben haben, können Sie sich den Effekt auf Ihr Behandlungsziel zeigen lassen. Drücken Sie dazu den Button "Eintritt simulieren".
""";

  String get selectItemTitle => "Wählen Sie Ihre Was wäre wenn-Situation aus:";

  String get completeDescriptionOne =>
      "Sie haben **5 Situationen** genannt. Damit beschreiben Sie Ihre künftigen Situationen und Maßnahmen sehr gut.";

  String get completeExplanationOne => "Sie haben ...";
  String get completeDescriptionTwo => "Möchten Sie weitere Situationen nennen?.";
  String get completeExplanationTwo =>
      "Sie können nun die Beschreibung der Negativen Aspekte abschließen. Natürlich können Sie alternativ gerne Ihre aktuelle Lebensqualität mit weiteren Negativen Aspekten noch besser beschreiben.";

  @override
  String get nextButtonText {
    switch (_navigationStep) {
      case NavigationSubStep.description:
        return "Künftige Situationen beschreiben";
      case NavigationSubStep.select:
        return "Situation beschreiben";
      case NavigationSubStep.edit:
        return "Bestätigen";
      case NavigationSubStep.assignTreatmentActivity:
        return "Maßnahmen der Situation zuweisen";
      case NavigationSubStep.complete:
        return "Künftige Situationen abschließen";
    }
  }

  @override
  void onBackButtonPressed(BuildContext context) {
    switch (_navigationStep) {
      case NavigationSubStep.description:
        super.onBackButtonPressed(context);

        break;
      case NavigationSubStep.select:
        _navigationStep = NavigationSubStep.description;
        break;
      case NavigationSubStep.edit:
        _navigationStep = NavigationSubStep.select;
        break;
      case NavigationSubStep.assignTreatmentActivity:
        _navigationStep = NavigationSubStep.edit;
        break;
      case NavigationSubStep.complete:
        _navigationStep = NavigationSubStep.assignTreatmentActivity;
        break;
    }
    notifyListeners();
  }

  @override
  bool get nextButtonEnabled =>
      _navigationStep == NavigationSubStep.select && newFutureSituationViewModel.selectedAspect != null ||
      _navigationStep == NavigationSubStep.edit &&
          newFutureSituationViewModel.aspectTextFieldController.text.trim().isNotEmpty ||
      _navigationStep == NavigationSubStep.complete ||
      _navigationStep == NavigationSubStep.assignTreatmentActivity ||
      _navigationStep == NavigationSubStep.description;

  @override
  void onNextButtonPressed(BuildContext context) {
    switch (_navigationStep) {
      case NavigationSubStep.description:
        _navigationStep = NavigationSubStep.select;

        break;
      case NavigationSubStep.select:
        _navigationStep = NavigationSubStep.edit;
        break;
      case NavigationSubStep.edit:
        newFutureSituationViewModel.onAddAspectActionPressed(context);
        _navigationStep = NavigationSubStep.assignTreatmentActivity;
        break;
      case NavigationSubStep.assignTreatmentActivity:
        if (_futureSituationsListViewModel.aspects.length >= 4) {
          _navigationStep = NavigationSubStep.complete;
        } else {
          _navigationStep = NavigationSubStep.select;
        }
        break;
      case NavigationSubStep.complete:
        super.onNextButtonPressed(context);
        break;
    }
    notifyListeners();
  }

  late AspectListViewModel _futureSituationsListViewModel;
  final TreatmentActivitySelectionViewModel treatmentActivititySelectionViewModel;
  final FutureSituation? focusAspect;

  final ContentService _contentService = getIt.get();

  final NewFutureSituationViewModel newFutureSituationViewModel;

  FutureSituationsPage get pageContent => _contentService.futureSituationsPage;

  AspectListViewModel get futureSituationsListViewModel => _futureSituationsListViewModel;

  @override
  void dispose() {
    super.dispose();
    _futureSituationsListViewModel.removeListener(_reactToAspectListChange);

    _futureSituationsListViewModel.dispose();
    treatmentActivititySelectionViewModel.dispose();
    _contentService.removeListener(notifyListeners);
  }

  void _reactToAspectListChange() {
    newFutureSituationViewModel.selectedAspect = _futureSituationsListViewModel.selectedAspect as FutureSituation?;
    treatmentActivititySelectionViewModel.selectedAspect =
        _futureSituationsListViewModel.selectedAspect as FutureSituation?;
    notifyListeners();
  }

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => true;

  @override
  bool get showFloatingAspectVisualizationIfSpaceAvailable => true;

  @override
  bool get showTreatmentGoalInVisualization => true;

  @override
  String get aspectSignificanceHighLabel => _contentService.futureSituationsPage.addAspectWidget.highSignificanceLabel;

  @override
  String get aspectsSignificanceLowLabel => _contentService.futureSituationsPage.addAspectWidget.lowSignificanceLabel;

  @override
  bool get simulateFutureAspects => true;
}
