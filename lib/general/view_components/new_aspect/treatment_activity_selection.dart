import 'package:flutter/material.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/model/weight.dart';
import 'package:pd_app/general/treatment_activities/treatment_activities_selection_view.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect_view_model.dart';
import 'package:pd_app/general/view_components/view_helper.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/future_situations/future_situation_treatment_activities_selection_view_model.dart';
import 'package:pd_app/use_cases/future_situations/new_future_situation_view_model.dart';
import 'package:provider/provider.dart';

class TreatmentActivitySelection<ViewModelClass extends NewAspectViewModel> extends StatelessWidget with Logging {
  @override
  Widget build(BuildContext context) {
    final TreatmentActivitySelectionViewModel viewModel = context.watch();
    return Row(
      children: [
        card(
            showCheckboxBelow: false,
            markdown: viewModel.selectedItemContent,
            assetPath: "assets/images/create.svg",
            more: viewModel.more),
        const SizedBox(width: 60),
        Expanded(
          child: ChangeNotifierProvider(
              create: (_) => FutureSituationTreatmentActivitiesSelectionViewModel(
                  futureSituation:
                      FutureSituation(name: 'asdfsda', weight: Weight(value: 0.5), treatmentActivitiyPreferences: [])),
              child: TreatmentActivitiesSelection<FutureSituationTreatmentActivitiesSelectionViewModel>()),
        )
      ],
    );
  }
}
