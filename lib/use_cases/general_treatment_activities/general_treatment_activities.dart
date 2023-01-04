import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/treatment_activities/treatment_activities_selection_view.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/use_cases/general_treatment_activities/general_treatment_activities_view_model.dart';
import 'package:provider/provider.dart';

class TreatmentActivities extends StatefulWidget {
  const TreatmentActivities({Key? key}) : super(key: key);

  static Widget page() {
    return ChangeNotifierProvider(create: (_) => TreatmentActivitiesViewModel(), child: const TreatmentActivities());
  }

  @override
  State<TreatmentActivities> createState() => _TreatmentActivitiesState();
}

class _TreatmentActivitiesState extends State<TreatmentActivities> with RootContextL10N {
  late TreatmentActivitiesViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch();
    return CreationProcessNavigation<TreatmentActivitiesViewModel>(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: Paddings.headlinePadding,
            child: Text(_viewModel.addTreatmentActivitiesTitle, style: Theme.of(context).textTheme.headlineLarge),
          ),
          Padding(
            padding: Paddings.headlineExplanationPadding,
            child: Text(
              _viewModel.addTreatmentActivitiesExplanation,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          ChangeNotifierProvider.value(
              value: _viewModel.treatmentActivitiesSelectionViewModel, child: TreatmentActivitiesSelection())
        ],
      ),
    );
  }
}
