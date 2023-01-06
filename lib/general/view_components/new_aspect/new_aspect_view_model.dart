import 'package:flutter/material.dart';
import 'package:pd_app/general/aspect_view_model/aspect_view_model.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/future_situations/future_situations_view_model.dart';

abstract class NewAspectViewModel with RootContextL10N, AspectViewModel, Logging, ChangeNotifier {
  NewAspectViewModel({this.onAspectAdded}) : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChange);
    aspectTextFieldController.addListener(_reactToTextChange);
  }

  AspectListChoice get aspectListChoice;

  /// this is called when an aspect has been added
  final void Function(BuildContext context)? onAspectAdded;

  final PatientDirectiveService _patientDirectiveService;

  String get examplesText;

  String get addAspectTitle;

  String get addAspectExplanation;

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

  void onAddAspectActionPressed(BuildContext context) {
    final Aspect newAspect = Aspect(name: aspectTextFieldController.text.trim(), weight: Weight(value: weight));
    final PatientDirective currentDirective = _patientDirectiveService.currentPatientDirective;

    final List<Aspect> aspectsToManipulate = aspectListChoice(currentDirective);
    aspectsToManipulate.add(newAspect);
    _patientDirectiveService.currentPatientDirective = currentDirective;

    onAspectAdded?.call(context);
  }

  VoidCallback? addAspect(BuildContext context) =>
      addAspectActionEnabled ? () => onAddAspectActionPressed(context) : null;

  void _reactToPatientDirectiveChange() {
    notifyListeners();
  }

  List<Group> get examples {
    return [
      Group(title: l10n.positiveAspectsGroupFamily, children: [
        Item(title: l10n.spendTimeWithFamily),
        Item(title: l10n.pet),
      ]),
      Group(title: l10n.positiveAspectsGroupLeisure, children: [
        Item(title: l10n.personalContacts),
        Item(title: l10n.myHome),
        Item(title: l10n.travelling),
      ]),
      Group(title: l10n.positiveAspectsGroupWork, children: [
        Item(title: l10n.myWork),
        Item(title: l10n.writingBooks),
      ]),
      Group(title: l10n.positiveAspectsGroupSport, children: [
        Item(title: l10n.jogging),
        Item(title: l10n.ridingTheBike),
      ]),
    ];
  }

  void chooseExample(String text) {
    aspectTextFieldController.text = text;
    notifyListeners();
  }
}
