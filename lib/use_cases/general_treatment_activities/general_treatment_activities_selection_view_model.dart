import 'package:pd_app/general/dynamic_content/content_definitions/treatment_activity.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/general/treatment_activities/treatment_activities_selection_view_model.dart';

class GeneralTreatmentActivitiesSelectionViewModel extends TreatmentActivitiesSelectionViewModel {
  GeneralTreatmentActivitiesSelectionViewModel() : _patientDirectiveService = getIt.get() {
    _patientDirectiveService.addListener(_reactToPatientDirectiveChanges);
    _contentService.addListener(notifyListeners);
  }

  final PatientDirectiveService _patientDirectiveService;

  final ContentService _contentService = getIt.get();

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
    return _patientDirectiveService.getGeneralTreatmentPreference(activity: activity) ?? activity.defaultValue.choice;
  }

  @override
  List<TreatmentActivity> get treatmentActivities => _contentService.treatmentActivities;

  @override
  void updateChoice(TreatmentActivity activity, String? choice) {
    final int choiceId = activity.choices.where((element) => element.choice == choice).first.id;
    _patientDirectiveService.updateGeneralTreatmentPreference(
        activity: activity.activity, choice: choice, choiceId: choiceId, activityId: activity.id);
  }

  @override
  String get addTreatmentActivitiesSubHeadline => _contentService.treatmentActivitiesPage.treatmentActivitiesTitle;
}
