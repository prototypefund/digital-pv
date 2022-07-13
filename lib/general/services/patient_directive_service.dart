import 'package:flutter/material.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/weight.dart';

class PatientDirectiveService with ChangeNotifier {
  PatientDirective _currentPatientDirective = PatientDirective(positiveAspects: [
    Aspect(name: "Zeit mit der Familie verbringen", weight: Weight(value: 0.7)),
    Aspect(name: "Haustier", weight: Weight(value: 0.5)),
    Aspect(name: "Reisen", weight: Weight(value: 0.4)),
    Aspect(name: "Essen", weight: Weight(value: 0.2)),
    Aspect(name: "Skifahren", weight: Weight(value: 0.25))
  ]);

  PatientDirective get currentPatientDirective => _currentPatientDirective;

  set currentPatientDirective(PatientDirective newValue) {
    _currentPatientDirective = newValue;
    notifyListeners();
  }

  void sortAspects() {
    currentPatientDirective.positiveAspects
        .sort((aspect1, aspect2) => aspect2.weight.value.compareTo(aspect1.weight.value));

    notifyListeners();
  }
}
