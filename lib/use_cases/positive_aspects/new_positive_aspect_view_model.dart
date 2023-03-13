import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pd_app/general/dynamic_content/aspects_example.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/navigation/routes.dart';
import 'package:pd_app/general/services/content_service.dart';
import 'package:pd_app/general/view_components/aspect_list_choice.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect_view_model.dart';

class NewPositiveAspectViewModel extends NewAspectViewModel<Aspect> {
  NewPositiveAspectViewModel() : _contentService = getIt.get() {
    _contentService.addListener(notifyListeners);
  }

  final ContentService _contentService;

  @override
  String get addAspectActionText => _contentService.positiveAspectsPage.addAspectWidget.addAspectActionLabel;

  @override
  String get addAspectTextfieldHint => _contentService.positiveAspectsPage.addAspectWidget.emptyTextFieldHint;

  @override
  AspectListChoice<Aspect> get aspectListChoice => (PatientDirective directive) => directive.positiveAspects;

  @override
  String get examplesText => _contentService.positiveAspectsPage.examplesTitle;

  @override
  void onAddAspectActionPressed(BuildContext context) {
    super.onAddAspectActionPressed(context);
    context.go(Routes.positiveAspects);
  }

  @override
  Aspect createNewAspect({required String name, required Weight weight}) {
    return Aspect(name: name, weight: weight);
  }

  @override
  List<AspectsExample> get aspectExamples => _contentService.positiveAspectsExamples;

  @override
  void dispose() {
    super.dispose();
    _contentService.removeListener(notifyListeners);
  }
}
