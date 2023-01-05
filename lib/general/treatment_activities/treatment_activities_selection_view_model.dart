import 'package:flutter/widgets.dart';
import 'package:pd_app/general/model/treatment_activity.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';

class TreatmentActivitiesSelectionViewModel with RootContextL10N, ChangeNotifier {
  TreatmentActivitiesSelectionViewModel(
      {required TreatmentActivityChoice hospitalizationSelection,
      required TreatmentActivityChoice intensiveTreatmentSelection,
      required TreatmentActivityChoice resuscitationSelection})
      : _hospitalizationSelection = hospitalizationSelection,
        _intensiveTreatmentSelection = intensiveTreatmentSelection,
        _resuscitationSelection = resuscitationSelection;

  String get addTreatmentActivitiesSubHeadline => l10n.addTreatmentActivitiesSubHeadline;

  String get addTreatmentActivitiesHospitalAdmission => l10n.addTreatmentActivitiesHospitalAdmission;

  String get addTreatmentActivitiesIntensiveTreatment => l10n.addTreatmentActivitiesIntensiveTreatment;

  String get addTreatmentActivitiesResuscitation => l10n.addTreatmentActivitiesResuscitation;

  TreatmentActivityChoice _hospitalizationSelection;
  TreatmentActivityChoice _intensiveTreatmentSelection;
  TreatmentActivityChoice _resuscitationSelection;

  TreatmentActivityChoice get hospitalizationSelection => _hospitalizationSelection;

  TreatmentActivityChoice get intensiveTreatmentSelection => _intensiveTreatmentSelection;

  TreatmentActivityChoice get resuscitationSelection => _resuscitationSelection;

  set hospitalizationSelection(TreatmentActivityChoice newValue) {
    _hospitalizationSelection = newValue;
    notifyListeners();
  }

  set intensiveTreatmentSelection(TreatmentActivityChoice newValue) {
    _intensiveTreatmentSelection = newValue;
    notifyListeners();
  }

  set resuscitationSelection(TreatmentActivityChoice newValue) {
    _resuscitationSelection = newValue;
    notifyListeners();
  }

  final List<TreatmentActivityChoice> hospitalizationList = [
    TreatmentActivityChoice.notSpecified,
    TreatmentActivityChoice.no,
    TreatmentActivityChoice.yes,
    TreatmentActivityChoice.symptomControl
  ];

  final List<TreatmentActivityChoice> intensiveTreatmentList = [
    TreatmentActivityChoice.notSpecified,
    TreatmentActivityChoice.no,
    TreatmentActivityChoice.yes
  ];

  final List<TreatmentActivityChoice> resuscitationList = [
    TreatmentActivityChoice.notSpecified,
    TreatmentActivityChoice.no,
    TreatmentActivityChoice.yes
  ];
}
