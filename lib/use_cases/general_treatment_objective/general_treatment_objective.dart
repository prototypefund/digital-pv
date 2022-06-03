import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/placeholder/patient_directive_view_placeholder.dart';
import 'package:pd_app/use_cases/general_treatment_objective/general_treatment_objective_view_model.dart';
import 'package:provider/provider.dart';

class GeneralTreatmentObjective extends StatelessWidget {
  const GeneralTreatmentObjective({Key? key}) : super(key: key);

  static Widget page() {
    final generalTreatmentObjectiveViewModel = GeneralTreatmentObjectiveViewModel();
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: generalTreatmentObjectiveViewModel),
      ChangeNotifierProvider<CreationProcessNavigationViewModel>.value(value: generalTreatmentObjectiveViewModel),
    ], child: const GeneralTreatmentObjective());
  }

  @override
  Widget build(BuildContext context) {
    return const CreationProcessNavigation(widget: PatientDirectiveViewPlaceholder(title: 'Behandlungsziel festlegen'));
  }
}
