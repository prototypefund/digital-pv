import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/positive_aspects_page.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/general/view_components/directive_visualization/triangle_painter.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/positive_aspects/new_positive_aspect_view_model.dart';
import 'package:pd_app/use_cases/positive_aspects/positive_aspects_list_view_model.dart';

enum NavigationStep { description, select, edit, complete }

class PositiveAspectsViewModel extends CreationProcessNavigationViewModel with Logging {
  final TrianglePainter trianglePainter = TrianglePainter();
  final TrianglePainter trianglePainterRight = TrianglePainter(tipDirection: TipDirection.right);

  PositiveAspectsViewModel({required Aspect? focusAspect})
      : newPositiveAspectViewModel = NewPositiveAspectViewModel(autofocus: focusAspect == null),
        _contentService = getIt.get() {
    _positiveAspectListViewModel = _positiveAspectListViewModel =
        PositiveAspectsListViewModel(focusAspect: focusAspect, scrollController: scrollController);
    _positiveAspectListViewModel.addListener(_reactToAspectListChange);
  }

  double currentSliderValue = 20;

  late PageController pageController;
  final TextEditingController aspectNameController = TextEditingController();
  final TextEditingController detailDescriptionController = TextEditingController();

  NavigationStep _navigationStep = NavigationStep.description;
  NavigationStep get navigationStep => _navigationStep;

  final ContentService _contentService;
  late AspectListViewModel _positiveAspectListViewModel;

  PositiveAspectsPage get pageContent => _contentService.positiveAspectsPage;

  AspectListViewModel get positiveAspectListViewModel => _positiveAspectListViewModel;

  final NewPositiveAspectViewModel newPositiveAspectViewModel;

  String get subtitle => "#### Maßnahmen und Situationen beschreiben";
  String get title => "## Wie geht es Ihnen aktuell?";
  String get subtopic => "### Positives";

  @override
  String get nextButtonText => "Positive Aspekte beschreiben";

  String get visualizationTitle => "### Aktuelle Lebensqualität";

  String get visualizationPositiveTitle => "Positive Aspekte";

  String get descriptionOne => "### Beschreiben Sie im ersten Schritt bitte Ihre aktuelle Lebensqualität";

  String get explanationOne =>
      "Diese Angaben unterstützen Sie einerseits bei der weiteren Entscheidungsfindung und machen anderer- seits Ihre Entscheidung besser nachvollziehbar.";

  String get descriptionTwo => "### Beginnen Sie mit den **positiven Aspekten** Ihrer aktuellen Lebensqualität.";
  String get explanationTwo =>
      "Sehen Sie sich gerne die folgenden Beispiele an. Trifft eines zu, können Sie es auswählen und übernehmen. Alternativ können Sie die Aspekte auch frei formulieren.";

  String get completeDescriptionOne =>
      "Sie haben **5 positive Aspekte** genannt. Damit beschreiben Sie Ihre Lebensqualität sehr gut.";

  String get completeExplanationOne =>
      "Sie haben Ihrer Lebensqualität mit 5 Aspekten be- schrieben. Das ist eine gute Grundlage, um Ihre Therapiewünsche nachvollziehen zu können.";
  String get completeDescriptionTwo => "Möchten Sie weitere positive Aspekte nennen?.";
  String get completeExplanationTwo =>
      "Sie können nun die Beschreibung der positiven Aspekte abschließen. Natürlich können Sie alternativ gerne Ihre aktuelle Lebensqualität mit weiteren positiven Aspekten noch besser beschreiben.";
  String get more => "Mehr";
  String get describePositiveAspectTitle => "### Bitte beschreiben Sie Ihren positiven Aspekt";

  String get aspectNameLabel => "Wie soll Ihr Aspekt heißen?";
  String get aspectNameHint => "Genesung";
  String get aspectDetailLabel => "Hier können Sie Details beschreiben (optional)";

  String get ownAspect => """
### Eigener Aspekt 
Positiver Aspekt des aktuellen Lebens
## Genesung""";

  String get lowWeightLabel => "niedrig";
  String get middleWeightLabel => "mittel";
  String get highWeightLabel => "hoch";

  String get selectAspectTitle => "## Welchen Aspekt möchten Sie beschreiben?";

  @override
  void dispose() {
    super.dispose();
    _positiveAspectListViewModel.removeListener(_reactToAspectListChange);
    _positiveAspectListViewModel.dispose();
  }

  void _reactToAspectListChange() {
    notifyListeners();
  }

  @override
  void onNextButtonPressed(BuildContext context) {
    switch (_navigationStep) {
      case NavigationStep.description:
        _navigationStep = NavigationStep.select;
        break;
      case NavigationStep.select:
        _navigationStep = NavigationStep.edit;
        break;
      case NavigationStep.edit:
        _navigationStep = NavigationStep.complete;
        break;
      case NavigationStep.complete:
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
}
