import 'package:flutter/widgets.dart';
import 'package:pd_app/general/model/treatment_activity.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';

abstract class TreatmentActivitiesSelectionViewModel with RootContextL10N, ChangeNotifier {
  TreatmentActivitiesSelectionViewModel();

  String get addTreatmentActivitiesSubHeadline => l10n.addTreatmentActivitiesSubHeadline;

  String get addTreatmentActivitiesHospitalAdmission => l10n.addTreatmentActivitiesHospitalAdmission;

  String get addTreatmentActivitiesIntensiveTreatment => l10n.addTreatmentActivitiesIntensiveTreatment;

  String get addTreatmentActivitiesResuscitation => l10n.addTreatmentActivitiesResuscitation;

  TreatmentActivityChoice get hospitalizationSelection;

  TreatmentActivityChoice get intensiveTreatmentSelection;

  TreatmentActivityChoice get resuscitationSelection;

  set hospitalizationSelection(TreatmentActivityChoice newValue);

  set intensiveTreatmentSelection(TreatmentActivityChoice newValue);

  set resuscitationSelection(TreatmentActivityChoice newValue);

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
