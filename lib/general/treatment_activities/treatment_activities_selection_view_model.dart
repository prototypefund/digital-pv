import 'package:flutter/widgets.dart';
import 'package:pd_app/general/model/treatment_activity.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';

class TreatmentActivitiesSelectionViewModel with RootContextL10N, ChangeNotifier {
  TreatmentActivitiesSelectionViewModel();

  String get addTreatmentActivitiesSubHeadline => l10n.addTreatmentActivitiesSubHeadline;

  String get addTreatmentActivitiesHospitalAdmission => l10n.addTreatmentActivitiesHospitalAdmission;

  String get addTreatmentActivitiesIntensiveTreatment => l10n.addTreatmentActivitiesIntensiveTreatment;

  String get addTreatmentActivitiesResuscitation => l10n.addTreatmentActivitiesResuscitation;

  TreatmentActivity? _hospitalizationSelection = TreatmentActivity.notSpecified;
  TreatmentActivity? _intensiveTreatmentSelection = TreatmentActivity.notSpecified;
  TreatmentActivity? _resuscitationSelection = TreatmentActivity.notSpecified;

  TreatmentActivity? get hospitalizationSelection => _hospitalizationSelection;

  TreatmentActivity? get intensiveTreatmentSelection => _intensiveTreatmentSelection;

  TreatmentActivity? get resuscitationSelection => _resuscitationSelection;

  set hospitalizationSelection(TreatmentActivity? newValue) {
    _hospitalizationSelection = newValue;
    notifyListeners();
  }

  set intensiveTreatmentSelection(TreatmentActivity? newValue) {
    _intensiveTreatmentSelection = newValue;
    notifyListeners();
  }

  set resuscitationSelection(TreatmentActivity? newValue) {
    _resuscitationSelection = newValue;
    notifyListeners();
  }

  final List<TreatmentActivity> hospitalizationList = [
    TreatmentActivity.notSpecified,
    TreatmentActivity.no,
    TreatmentActivity.yes,
    TreatmentActivity.symptomControl
  ];

  final List<TreatmentActivity> intensiveTreatmentList = [
    TreatmentActivity.notSpecified,
    TreatmentActivity.no,
    TreatmentActivity.yes
  ];

  final List<TreatmentActivity> resuscitationList = [
    TreatmentActivity.notSpecified,
    TreatmentActivity.no,
    TreatmentActivity.yes
  ];
}
