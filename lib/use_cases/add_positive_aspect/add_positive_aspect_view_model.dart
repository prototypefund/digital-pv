import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/aspect_view_model/aspect_view_model.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';

class AddPositiveAspectViewModel extends CreationProcessNavigationViewModel with AspectViewModel {
  AddPositiveAspectViewModel() : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChange);
  }

  final PatientDirectiveService _patientDirectiveService;

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChange);
  }

  final TextEditingController aspectTextFieldController = TextEditingController();

  @override
  bool get nextButtonEnabled => false;

  @override
  String get nextButtonText => l10n.addPositiveAspectNavigationButton;

  String get addPositiveAspectTextfieldHint => l10n.addPositiveAspectTextFieldHint;

  String get addPositiveAspectActionText => l10n.addPositiveAspectCallToAction;

  double _weight = 0.5;

  @override
  void onNextButtonPressed(BuildContext context) {}

  @override
  void onBackButtonPressed(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
    } else {
      context.go(Routes.positiveAspects);
    }
  }

  bool get addPositiveAspectActionEnabled => aspectTextFieldController.text.trim().isNotEmpty;

  double get weight => _weight;

  set weight(double newWeight) {
    _weight = newWeight;
    notifyListeners();
  }

  void onAddPositiveAspectActionPressed(BuildContext context) {
    final Aspect newPositiveAspect = Aspect(name: aspectTextFieldController.text.trim(), weight: Weight(value: weight));
    final PatientDirective currentDirective = _patientDirectiveService.currentPatientDirective;
    currentDirective.positiveAspects.add(newPositiveAspect);
    _patientDirectiveService.currentPatientDirective = currentDirective;
    _patientDirectiveService.sortAspects();

    context.go(Routes.positiveAspects);
  }

  VoidCallback? addPositiveAspect(BuildContext context) =>
      addPositiveAspectActionEnabled ? () => onAddPositiveAspectActionPressed(context) : null;

  void _reactToPatientDirectiveChange() {
    notifyListeners();
  }

  List<String> get examples {
    return [
      "Zeit mit der Familie verbringen",
      "Haustier",
      "Mein Zuhause",
      "Persönliche Kontakte pflegen",
      "Meine Arbeit",
      "Reisen",
      "Joggen",
      "Radfahren",
      "Kochen",
      "Bücher schreiben"
    ];
  }

  void chooseExample(String text) {
    aspectTextFieldController.text = text;
    notifyListeners();
  }
}
