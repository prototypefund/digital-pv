import 'package:flutter/material.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/treatment_activity.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/treatment_activities/treatment_activities_selection_view_model.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/general/view_components/dpv_dropdown.dart';
import 'package:pd_app/logging.dart';
import 'package:provider/provider.dart';

class TreatmentActivitiesSelection<ViewModelType extends TreatmentActivitiesSelectionViewModel> extends StatelessWidget
    with RootContextL10N, Logging {
  @override
  Widget build(BuildContext context) {
    logger.v('rebuilding TreatmentActivitiesSelection');
    final ViewModelType viewModel = context.watch();
    return Column(
      children: [
        Center(
          child: Padding(
            padding: Paddings.headlineExplanationPadding,
            child: Center(
              child: Text(
                viewModel.addTreatmentActivitiesSubHeadline,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ),
        Column(
          children: viewModel.treatmentActivities.map((e) => _buildTreatmentActivityChoice(context, e)).toList(),
        ),
      ],
    );
  }

  Widget _buildTreatmentActivityChoice(BuildContext context, TreatmentActivity activity) {
    final ViewModelType viewModel = context.watch();

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DPVDropDown(
              initialValue: viewModel.getCurrentChoice(activity)!,
              description: Text(
                activity.activity,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              onChanged: (String? value) {
                logger.d('changing activity ${activity.activity} to value $value');
                viewModel.updateChoice(activity, value);
              },
              options: activity.choices.map((value) => value.choice).toList()),
        ],
      ),
    );
  }
}
