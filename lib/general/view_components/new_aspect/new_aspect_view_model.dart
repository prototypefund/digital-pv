import 'package:flutter/material.dart';
import 'package:pd_app/general/aspect_view_model/aspect_view_model.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/aspects_example.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/general/view_components/aspect_examples/aspect_examples_model.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';
import 'package:pd_app/logging.dart';

abstract class NewAspectViewModel<AspectType extends Aspect>
    with RootContextL10N, AspectViewModel, Logging, ChangeNotifier {
  NewAspectViewModel() : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChange);
    aspectTextFieldController.addListener(_reactToTextChange);
  }

  AspectListChoice<AspectType> get aspectListChoice;

  final PatientDirectiveService _patientDirectiveService;

  String get examplesText;

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChange);
    aspectTextFieldController.removeListener(_reactToTextChange);
  }

  final TextEditingController aspectTextFieldController = TextEditingController();

  String get addAspectTextfieldHint;

  String get addAspectActionText;

  double _weight = 0.5;

  bool get addAspectActionEnabled => aspectTextFieldController.text.trim().isNotEmpty;

  double get weight => _weight;

  String get examplesTitle => l10n.examples;

  set weight(double newWeight) {
    _weight = newWeight;
    notifyListeners();
  }

  void _reactToTextChange() {
    notifyListeners();
  }

  AspectType createNewAspect({required String name, required Weight weight});

  void onAddAspectActionPressed(BuildContext context) {
    final Aspect newAspect =
        createNewAspect(name: aspectTextFieldController.text.trim(), weight: Weight(value: weight));
    final PatientDirective currentDirective = _patientDirectiveService.currentPatientDirective;

    final List<Aspect> aspectsToManipulate = aspectListChoice(currentDirective);
    aspectsToManipulate.add(newAspect);
    _patientDirectiveService.currentPatientDirective = currentDirective;

    aspectTextFieldController.text = "";
    notifyListeners();
  }

  VoidCallback? addAspect(BuildContext context) =>
      addAspectActionEnabled ? () => onAddAspectActionPressed(context) : null;

  void _reactToPatientDirectiveChange() {
    notifyListeners();
  }

  List<AspectsExample> get aspectExamples;

  List<Group> get examples {
    final List<AspectsExample> examplesContent = aspectExamples;

    final Set<String> groups = examplesContent.map((e) => e.example.group).toSet();
    final Map<String, Group> groupMap = {};
    for (final String group in groups) {
      groupMap[group] = Group(title: group, children: []);
    }
    for (final AspectsExample example in examplesContent) {
      groupMap[example.example.group]!.children.add(Item(title: example.example.title));
    }
    return groupMap.values.toList();
  }

  void chooseExample(String text) {
    aspectTextFieldController.text = text;
    notifyListeners();
  }
}
