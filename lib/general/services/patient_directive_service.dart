import 'package:flutter/material.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/treatment_activity.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/treatment_activity_preference.dart';

class PatientDirectiveService with ChangeNotifier {
  PatientDirectiveService();

  PatientDirective _currentPatientDirective = PatientDirective(
      positiveAspects: [], futureSituationAspects: [], negativeAspects: [], generalTreatmentPreferences: []);

  PatientDirective get currentPatientDirective => _currentPatientDirective;

  set currentPatientDirective(PatientDirective newValue) {
    _currentPatientDirective = newValue;
    notifyListeners();
  }

  void updateGeneralTreatmentPreference(
      {required String activity, required String? choice, required int? choiceId, required int? activityId}) {
    _updateTreatmentPreference(
        preferenceList: currentPatientDirective.generalTreatmentPreferences,
        activity: activity,
        choice: choice,
        choiceId: choiceId,
        activityId: activityId);
  }

  String? getGeneralTreatmentPreference({required TreatmentActivity activity}) {
    return _getTreatmentPreference(
        preferenceList: currentPatientDirective.generalTreatmentPreferences, activity: activity);
  }

  String? getTreatmentPreference({required FutureSituation futureSituation, required TreatmentActivity activity}) {
    return _getTreatmentPreference(preferenceList: futureSituation.treatmentActivitiyPreferences, activity: activity);
  }

  String? _getTreatmentPreference(
      {required List<TreatmentActivityPreference> preferenceList, required TreatmentActivity activity}) {
    final matchingActivities = preferenceList.where((element) => element.activity == activity.activity);
    if (matchingActivities.isEmpty) {
      return null;
    } else {
      return matchingActivities.first.choice;
    }
  }

  void _updateTreatmentPreference(
      {required List<TreatmentActivityPreference> preferenceList,
      required String activity,
      required String? choice,
      required int? choiceId,
      required int? activityId}) {
    final matchingActivities = preferenceList.where((element) => element.activity == activity);
    if (matchingActivities.isNotEmpty) {
      preferenceList.removeWhere((element) => element.activity == activity);
    }
    if (choice != null) {
      preferenceList.add(
          TreatmentActivityPreference(activity: activity, choice: choice, activityId: activityId, choiceId: choiceId));
    }

    notifyListeners();
  }

  void updateTreatmentPreference(
      {required FutureSituation futureSituation,
      required String activity,
      required String? choice,
      required int? activityId,
      required int? choiceId}) {
    _updateTreatmentPreference(
        preferenceList: futureSituation.treatmentActivitiyPreferences,
        activity: activity,
        choice: choice,
        choiceId: choiceId,
        activityId: activityId);
  }
}
