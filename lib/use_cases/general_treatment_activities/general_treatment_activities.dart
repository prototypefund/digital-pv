import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/markdown/markdown_body.dart';
import 'package:pd_app/general/treatment_activities/treatment_activities_selection_view.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/use_cases/general_treatment_activities/general_treatment_activities_selection_view_model.dart';
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
    return CreationProcessNavigation<GeneralTreatmentActivitiesViewModel>(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarkdownBody(
              content: context.select((GeneralTreatmentActivitiesViewModel viewModel) => viewModel.pageContent).intro),
          const SizedBox(
            height: 48,
          ),
          ChangeNotifierProvider(
              create: (_) => GeneralTreatmentActivitiesSelectionViewModel(),
              child: TreatmentActivitiesSelection<GeneralTreatmentActivitiesSelectionViewModel>()),
          const SizedBox(
            height: 20,
          ),
          MarkdownBody(
              content:
                  context.select((GeneralTreatmentActivitiesViewModel viewModel) => viewModel.pageContent).outro ?? ''),
        ],
      ),
    );
  }
}
