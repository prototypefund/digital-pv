import 'package:flutter/widgets.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/treatment_activity.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';

abstract class TreatmentActivitiesSelectionViewModel with RootContextL10N, ChangeNotifier {
  TreatmentActivitiesSelectionViewModel();

  List<TreatmentActivity> get treatmentActivities;

  String getActivityText(TreatmentActivity activity) => activity.activity;

  String? getCurrentChoice(TreatmentActivity activity);

  void updateChoice(TreatmentActivity activity, String? choice);

  String get addTreatmentActivitiesSubHeadline;
}
