import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/use_cases/general_treatment_activities/general_treatment_activities_view_model.dart';
import 'package:provider/provider.dart';

class TreatmentActivities extends StatefulWidget {
  const TreatmentActivities({super.key});

  static Widget page() {
    return ChangeNotifierProvider(
        create: (_) => GeneralTreatmentActivitiesViewModel(), child: const TreatmentActivities());
  }

  @override
  State<TreatmentActivities> createState() => _TreatmentActivitiesState();
}

class _TreatmentActivitiesState extends State<TreatmentActivities> with RootContextL10N {
  @override
  Widget build(BuildContext context) {
    return const CreationProcessNavigation<GeneralTreatmentActivitiesViewModel>(widget: SizedBox());
  }
}
