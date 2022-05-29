import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/placeholder/patient_directive_view_placeholder.dart';
import 'package:pd_app/use_cases/treatment_activities/treatment_activities_view_model.dart';
import 'package:provider/provider.dart';

class TreatmentActivities extends StatelessWidget {
  const TreatmentActivities({Key? key}) : super(key: key);

  static Widget page() {
    final treatmentActivitiesViewModel = TreatmentActivitiesViewModel();
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: treatmentActivitiesViewModel),
      ChangeNotifierProvider<CreationProcessNavigationViewModel>.value(value: treatmentActivitiesViewModel)
    ], child: const TreatmentActivities());
  }

  @override
  Widget build(BuildContext context) {
    return const CreationProcessNavigation(
        widget: PatientDirectiveViewPlaceholder(title: 'Behandlungsmaßnahmen festlegen'));
  }
}
