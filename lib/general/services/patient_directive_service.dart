import 'package:flutter/material.dart';
import 'package:pd_app/general/model/patient_directive.dart';

class PatientDirectiveService with ChangeNotifier {
  PatientDirectiveService();

  PatientDirective _currentPatientDirective =
      PatientDirective(positiveAspects: [], futureSituationAspects: [], negativeAspects: []);

  PatientDirective get currentPatientDirective => _currentPatientDirective;

  set currentPatientDirective(PatientDirective newValue) {
    _currentPatientDirective = newValue;
    notifyListeners();
  }
}
