import 'package:flutter/material.dart';
import 'package:pd_app/general/aspect_view_model/aspect_view_model.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/negative_aspects_page.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/general/view_components/directive_visualization/triangle_painter.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/negative_aspects/negative_aspects_list_view_model.dart';
import 'package:pd_app/use_cases/negative_aspects/new_negative_aspect_view_model.dart';
import 'package:pd_app/use_cases/positive_aspects/positive_aspects_view_model.dart';

class NegativeAspectsViewModel extends CreationProcessNavigationViewModel with AspectViewModel, Logging {
  NegativeAspectsViewModel({required Aspect? focusAspect})
      : newNegativeAspectViewModel = NewNegativeAspectViewModel(autofocus: focusAspect == null),
        aspectNameController = TextEditingController(),
        detailDescriptionController = TextEditingController() {
    _negativeAspectsListViewModel =
        NegativeAspectsListViewModel(focusAspect: focusAspect, scrollController: scrollController);
    _contentService.addListener(notifyListeners);

    _negativeAspectsListViewModel.addListener(_reactToAspectListChange);
  }

  final TrianglePainter trianglePainter = TrianglePainter();
  final TrianglePainter trianglePainterRight = TrianglePainter(tipDirection: TipDirection.right);

  late PageController pageController;
  final TextEditingController aspectNameController;
  final TextEditingController detailDescriptionController;

  NavigationSubStep _navigationStep = NavigationSubStep.description;
  NavigationSubStep get navigationStep => _navigationStep;

  final ContentService _contentService = getIt.get();

  late AspectListViewModel _negativeAspectsListViewModel;

  final NewNegativeAspectViewModel newNegativeAspectViewModel;

  NegativeAspectsPage get pageContent => _contentService.negativeAspectsPage;

  AspectListViewModel get negativeAspectsListViewModel => _negativeAspectsListViewModel;

  String get selectionTitle => "### Ausgewählt:";
  String get selectionContent => "#### Bitte wählen Sie eine der folgenden Aktionen aus.";
  String get selectionDeleteButtonTitle => "Löschen";
  String get selectionEditButtonTitle => "Bearbeiten";

  String get subtitle => "#### Maßnahmen und Situationen beschreiben";
  String get title => "## Wie geht es Ihnen aktuell?";
  String get subtopic => "### Negatives";

  void editItem(String item) {
    final aspect = negativeAspectsListViewModel.aspects.firstWhere((element) => item == element.name);
    aspect.isSelected = true;
    newNegativeAspectViewModel.selectedAspect = aspect;
    _navigationStep = NavigationSubStep.edit;
    notifyListeners();
  }

  void deleteItem(BuildContext context, String item) {
    final aspect = negativeAspectsListViewModel.aspects.firstWhere((element) => item == element.name);
    negativeAspectsListViewModel.removeAspect(aspect: aspect, context: context);
    notifyListeners();
  }

  @override
  String get nextButtonText {
    switch (_navigationStep) {
      case NavigationSubStep.description:
        return "Negative Aspekte beschreiben";
      case NavigationSubStep.select:
        return "Aspekt beschreiben";
      case NavigationSubStep.edit:
        return "Bestätigen";
      case NavigationSubStep.complete:
        return "Negative Aspekte abschließen";
    }
  }

  String get visualizationTitle => "### Aktuelle Lebensqualität";

  String get visualizationNegativeTitle => "Negative Aspekte";

  String get descriptionOne => "### Sie haben Ihre positiven Aspekte beschrieben. Sehr gut!";

  String get explanationOne =>
      "Diese Angaben unterstützen Sie einerseits bei der weiteren Entscheidungsfindung und machen anderer- seits Ihre Entscheidung besser nachvollziehbar.";

  String get descriptionTwo =>
      "### Machen Sie nun bitte mit den **negativen Aspekten** Ihrer aktuellen Lebensqualität weiter.";
  String get explanationTwo =>
      "Sehen Sie sich gerne die folgenden Beispiele an. Trifft eines zu, können Sie es auswählen und übernehmen. Alternativ können Sie die Aspekte auch frei formulieren. Gibt es keine negativen Aspekte, können Sie diesen [[Schritt überspringen.]](skip)";

  String get completeDescriptionOne =>
      "Sie haben **3 Negative Aspekte** genannt. Damit beschreiben Sie Ihre Lebensqualität sehr gut.";

  String get completeExplanationOne =>
      "Sie haben Ihrer Lebensqualität mit 3 Aspekten beschrieben. Das ist eine gute Grundlage, um Ihre Therapiewünsche nachvollziehen zu können.";
  String get completeDescriptionTwo => "Möchten Sie weitere Negative Aspekte nennen?.";
  String get completeExplanationTwo =>
      "Sie können nun die Beschreibung der Negativen Aspekte abschließen. Natürlich können Sie alternativ gerne Ihre aktuelle Lebensqualität mit weiteren Negativen Aspekten noch besser beschreiben.";
  String get more => "Mehr";
  String get describeNegativeAspectTitle => "### Bitte beschreiben Sie Ihren Negativen Aspekt";

  String get aspectNameLabel => "Wie soll Ihr Aspekt heißen?";
  String get aspectNameHint => "Genesung";
  String get aspectDetailLabel => "Hier können Sie Details beschreiben (optional)";

  String get selectedItemContent => """
### Eigener Aspekt
Negativer Aspekt des aktuellen Lebens
## Genesung""";

  @override
  void dispose() {
    super.dispose();
    _negativeAspectsListViewModel.dispose();
    _negativeAspectsListViewModel.removeListener(_reactToAspectListChange);
  }

  void _reactToAspectListChange() {
    newNegativeAspectViewModel.selectedAspect = _negativeAspectsListViewModel.selectedAspect;
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
  bool get nextButtonEnabled =>
      _navigationStep == NavigationSubStep.select && newNegativeAspectViewModel.selectedAspect != null ||
      _navigationStep == NavigationSubStep.edit &&
          newNegativeAspectViewModel.aspectTextFieldController.text.trim().isNotEmpty ||
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
        if (_negativeAspectsListViewModel.aspects.length >= 2) {
          _navigationStep = NavigationSubStep.complete;
        } else {
          _navigationStep = NavigationSubStep.select;
        }
        newNegativeAspectViewModel.onAddAspectActionPressed(context);
        break;
      case NavigationSubStep.complete:
        super.onNextButtonPressed(context);
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

  @override
  String get aspectSignificanceHighLabel => _contentService.negativeAspectsPage.aspectListWidget.highSignificanceLabel;

  @override
  String get aspectsSignificanceLowLabel => _contentService.negativeAspectsPage.aspectListWidget.lowSignificanceLabel;
}
