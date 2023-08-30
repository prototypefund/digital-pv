import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/logging.dart';

class UpsertPatientDirectivePage4ViewModel extends CreationProcessNavigationViewModel with Logging {
  final ContentService _contentService;

  bool _cardOneIsSelected = false;
  bool _cardTwoIsSelected = false;
  bool _cardThreeIsSelected = false;
  @override
  bool get showAppBar => false;

  UpsertPatientDirectivePage4ViewModel() : _contentService = getIt.get() {
    _contentService.addListener(notifyListeners);
  }

  @override
  void dispose() {
    super.dispose();
    _contentService.removeListener(notifyListeners);
  }

  String get subtitle => "Patientenverfügung erstellen";
  String get title => "Für den Fall meiner Entscheidungsunfähigkeit möchte ich";
  String get dismiss => "Schließen";
  String get moreInfo => "Weitere Informationen";
  String get importantPointsQuestion => "**Welcher der folgenden\n Punkte ist Ihnen besonders wichtig?**";
  String get importantPointsAnswer =>
      "Mit der Beantwortung dieser Frage wird Ihre Patientenverfügung individuell auf Ihre Wünsche ausgerichtet.";
  String get cardOneText => "eine (oder mehrere) **Vertretungs- person(en)** benennen.";
  String get cardOneDescription =>
      'Sie legen mit der Patientenverfügung nur fest, welche Person im Falle Ihrer Entscheidungunsfähigkeit Ihre Behandlungswünsche vertreten soll. [[Mehr]](card_one) ';
  String get cardOneMore =>
      "Diese Person setzt im Falle einer Entscheidungsunfähigkeit Ihre Behandlungsziele durch. Das setzt voraus, dass sie diesem Menschen Ihre Behandlungswünsche mitgeteilt haben und er/sie Sie vertreten möchte. Eine Vertretungsperson kann ein/e Verwandte/r, ein/e Ärzt:in oder ein anderer Mensch Ihres Vertrauens sein.";
  String get cardTwoText =>
      "eine **Kleine Patientenverfügung** erstellen und medizinische Maßnahmen benennen, die ich grundsätzlich nicht möchte.";
  String get cardTwoDescription =>
      'Sie legen mit der Patientenverfügung fest, welche medizinischen Maßnahmen Sie unabhängig von der Situation auf keinen Fall wünschen. [[Mehr]](card_two) ';
  String get cardTwoMore =>
      "Das trifft dann für jeden medizinischen Notfall zu, bei dem Sie nicht entscheidungsfähig sind. Sie können beispielsweise im Voraus festlegen, dass Sie prinzipiell keine Mitnahme ins Krankenhaus wünschen. Einzelne Situationen, in denen spezielle medizinische Maßnahme abgelehnt oder gewünscht sind, werden nicht beschrieben. Insofern handelt es sich um eine gültige, kurze Variante der Patientenverfügung.";
  String get cardThreeText =>
      "eine **Große Patientenverfügung** erstellen und medizinische Maßnahmen benennen, die ich in bestimmten Situationen nicht mehr möchte.";
  String get cardThreeDescription =>
      'Sie legen mit der Patientenverfügung fest, welche medizinischen Maßnahmen Sie in welcher Situation ablehnen (oder wünschen), für den Fall, dass Sie nicht mehr entscheidungsfähig sind. [[Mehr]](card_three) ';
  String get cardThreeMore =>
      "So können Sie sehr detailliert Ihre Behandlungs- wünsche beschreiben und festlegen. Sie haben beispielsweise Sorge vor der Ent- wicklung einer Demenz und konkrete Vorstellungen, welche medizinische Behandlung Sie im Fall einer Entscheidungsunfähigkeit ab- lehnen. Wir helfen wir Ihnen dabei, Ihren Behandlungswunsch komfortabel und rechtskräftig festzulegen.";
  String get continueButtonTitle => "weiter";

  bool get cardOneIsSelected => _cardOneIsSelected;
  set cardOneIsSelected(bool value) {
    _cardOneIsSelected = value;
    notifyListeners();
  }

  bool get cardTwoIsSelected => _cardTwoIsSelected;
  set cardTwoIsSelected(bool value) {
    _cardTwoIsSelected = value;
    notifyListeners();
  }

  bool get cardThreeIsSelected => _cardThreeIsSelected;
  set cardThreeIsSelected(bool value) {
    _cardThreeIsSelected = value;
    notifyListeners();
  }

  bool deactivateAll() => _cardOneIsSelected = _cardTwoIsSelected = _cardThreeIsSelected = false;

  bool get isOneCardSelected => _cardOneIsSelected || _cardTwoIsSelected || _cardThreeIsSelected;

  @override
  bool get showAspectVisualizationInNavbarIfNotShowingFloatingVisualization => false;

  @override
  bool get showTreatmentGoalInVisualization => false;
}
