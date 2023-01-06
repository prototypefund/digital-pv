import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';

class PositiveAspectsListViewModel extends AspectListViewModel {
  PositiveAspectsListViewModel();

  @override
  String get addAspectCallToActionText => l10n.addPositiveAspectCallToAction;

  @override
  String get emptyAspectListsMessageText => l10n.positiveAspectsEmptyText;

  @override
  AspectListChoice get aspectListChoice => (PatientDirective directive) => directive.positiveAspects;

  @override
  bool get showTreatmentOptions => false;

  @override
  bool get showAddAspectCallToAction => true;
}
