import 'package:pd_app/general/dynamic_content/content_definitions/treatment_activity.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/treatment_activities/treatment_activities_selection_view_model.dart';

class FutureSituationTreatmentActivitiesSelectionViewModel extends TreatmentActivitiesSelectionViewModel {
  FutureSituationTreatmentActivitiesSelectionViewModel({required this.futureSituation})
      : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChanges);
    _contentService.addListener(notifyListeners);
  }

  final ContentService _contentService = getIt.get();

  final FutureSituation futureSituation;

  final PatientDirectiveService _patientDirectiveService;

  @override
  void dispose() {
    super.dispose();
    _patientDirectiveService.removeListener(_reactToPatientDirectiveChanges);
    _contentService.removeListener(notifyListeners);
  }

  void _reactToPatientDirectiveChanges() {
    notifyListeners();
  }

  @override
  String? getCurrentChoice(TreatmentActivity activity) {
    return _patientDirectiveService.getTreatmentPreference(futureSituation: futureSituation, activity: activity) ??
        activity.defaultValue.choice;
  }

  @override
  List<TreatmentActivity> get treatmentActivities => _contentService.treatmentActivities;

  @override
  void updateChoice(TreatmentActivity activity, String? choice) {
    final int choiceId = activity.choices.where((element) => element.choice == choice).first.id;
    _patientDirectiveService.updateTreatmentPreference(
        futureSituation: futureSituation,
        activity: activity.activity,
        choice: choice,
        activityId: activity.id,
        choiceId: choiceId);
  }

  @override
  String get addTreatmentActivitiesSubHeadline => _contentService.futureSituationsPage.treatmentActivitiesTitle;
}
