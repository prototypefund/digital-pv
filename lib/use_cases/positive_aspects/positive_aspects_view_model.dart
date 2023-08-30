import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/positive_aspects_page.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/positive_aspects/new_positive_aspect_view_model.dart';
import 'package:pd_app/use_cases/positive_aspects/positive_aspects_list_view_model.dart';

enum NavigationSubStep { description, select, edit, complete }

class PositiveAspectsViewModel extends CreationProcessNavigationViewModel with Logging {
  PositiveAspectsViewModel({required Aspect? focusAspect})
      : newPositiveAspectViewModel = NewPositiveAspectViewModel(autofocus: focusAspect == null),
        _contentService = getIt.get() {
    _positiveAspectListViewModel = _positiveAspectListViewModel =
        PositiveAspectsListViewModel(focusAspect: focusAspect, scrollController: scrollController);
    _positiveAspectListViewModel.addListener(_reactToAspectListChange);
  }

  NavigationSubStep _navigationStep = NavigationSubStep.description;
  NavigationSubStep get navigationStep => _navigationStep;

  final ContentService _contentService;
  late AspectListViewModel _positiveAspectListViewModel;

  PositiveAspectsPage get pageContent => _contentService.positiveAspectsPage;

  AspectListViewModel get positiveAspectListViewModel => _positiveAspectListViewModel;

  final NewPositiveAspectViewModel newPositiveAspectViewModel;

  void editItem(String item) {
    final aspect = positiveAspectListViewModel.aspects.firstWhere((element) => item == element.name);
    aspect.isSelected = true;
    newPositiveAspectViewModel.selectedAspect = aspect;
    _navigationStep = NavigationSubStep.edit;
    notifyListeners();
  }

  void deleteItem(BuildContext context, String item) {
    final aspect = positiveAspectListViewModel.aspects.firstWhere((element) => item == element.name);
    positiveAspectListViewModel.removeAspect(aspect: aspect, context: context);
    notifyListeners();
  }

  String get subtitle => "#### Maßnahmen und Situationen beschreiben";
  String get title => "## Wie geht es Ihnen aktuell?";
  String get subtopic => "### Positives";

  String get selectionTitle => "### Ausgewählt:";
  String get selectionContent => "#### Bitte wählen Sie eine der folgenden Aktionen aus.";
  String get selectionDeleteButtonTitle => "Löschen";
  String get selectionEditButtonTitle => "Bearbeiten";

  @override
  String get nextButtonText {
    switch (_navigationStep) {
      case NavigationSubStep.description:
        return "Positive Aspekte beschreiben";
      case NavigationSubStep.select:
        return "Aspekt beschreiben";
      case NavigationSubStep.edit:
        return "Bestätigen";
      case NavigationSubStep.complete:
        return "Positive Aspekte abschließen";
    }
  }

  String get visualizationTitle => "### Aktuelle Lebensqualität";

  String get visualizationPositiveTitle => "Positive Aspekte";

  String get descriptionOne => "### Beschreiben Sie im ersten Schritt bitte Ihre aktuelle Lebensqualität";

  String get explanationOne =>
      "Diese Angaben unterstützen Sie einerseits bei der weiteren Entscheidungsfindung und machen anderer- seits Ihre Entscheidung besser nachvollziehbar.";

  String get descriptionTwo => "### Beginnen Sie mit den **positiven Aspekten** Ihrer aktuellen Lebensqualität.";
  String get explanationTwo =>
      "Sehen Sie sich gerne die folgenden Beispiele an. Trifft eines zu, können Sie es auswählen und übernehmen. Alternativ können Sie die Aspekte auch frei formulieren.";

  String get completeDescriptionOne =>
      "Sie haben **3 positive Aspekte** genannt. Damit beschreiben Sie Ihre Lebensqualität sehr gut.";

  String get completeExplanationOne =>
      "Sie haben Ihrer Lebensqualität mit 3 Aspekten beschrieben. Das ist eine gute Grundlage, um Ihre Therapiewünsche nachvollziehen zu können.";
  String get completeDescriptionTwo => "Möchten Sie weitere positive Aspekte nennen?.";
  String get completeExplanationTwo =>
      "Sie können nun die Beschreibung der positiven Aspekte abschließen. Natürlich können Sie alternativ gerne Ihre aktuelle Lebensqualität mit weiteren positiven Aspekten noch besser beschreiben.";

  @override
  void dispose() {
    super.dispose();
    _positiveAspectListViewModel.removeListener(_reactToAspectListChange);
    _positiveAspectListViewModel.dispose();
  }

  void _reactToAspectListChange() {
    newPositiveAspectViewModel.selectedAspect = _positiveAspectListViewModel.selectedAspect;
    notifyListeners();
  }

  @override
  bool get nextButtonEnabled =>
      _navigationStep == NavigationSubStep.select && newPositiveAspectViewModel.selectedAspect != null ||
      _navigationStep == NavigationSubStep.edit &&
          newPositiveAspectViewModel.aspectTextFieldController.text.trim().isNotEmpty ||
      _navigationStep == NavigationSubStep.complete ||
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
        if (_positiveAspectListViewModel.aspects.length >= 2) {
          _navigationStep = NavigationSubStep.complete;
        } else {
          _navigationStep = NavigationSubStep.select;
        }
        newPositiveAspectViewModel.onAddAspectActionPressed(context);
        break;
      case NavigationSubStep.complete:
        super.onNextButtonPressed(context);
        break;
    }
    notifyListeners();
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
      case NavigationSubStep.complete:
        _navigationStep = NavigationSubStep.edit;
        break;
    }
    notifyListeners();
  }

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => true;

  @override
  bool get showFloatingAspectVisualizationIfSpaceAvailable => true;

  @override
  bool get showTreatmentGoalInVisualization => false;
}
