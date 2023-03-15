import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/markdown/markdown_body.dart';
import 'package:pd_app/general/themes/constraints.dart';
import 'package:pd_app/general/themes/sizes.dart';
import 'package:pd_app/general/view_components/aspect_visualization/aspect_visualization.dart';
import 'package:pd_app/general/view_components/aspect_visualization/aspect_visualization_view_model.dart';
import 'package:pd_app/general/view_components/explanation_box/explanation_box.dart';
import 'package:pd_app/use_cases/general_treatment_objective/general_treatment_objective_view_model.dart';
import 'package:provider/provider.dart';

class GeneralTreatmentObjective extends StatelessWidget {
  const GeneralTreatmentObjective({super.key});

  static Widget page() {
    return ChangeNotifierProvider(
        create: (_) => GeneralTreatmentObjectiveViewModel(), child: const GeneralTreatmentObjective());
  }

  @override
  Widget build(BuildContext context) {
    final GeneralTreatmentObjectiveViewModel viewModel = context.watch();
    return CreationProcessNavigation<GeneralTreatmentObjectiveViewModel>(
        widget: SizedBox(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        MarkdownBody(content: viewModel.intro),
        const SizedBox(
          height: 24,
        ),
        MarkdownBody(content: viewModel.summary),
        const SizedBox(
          height: 24,
        ),
        ExplanationBox.fromContextualHelp(contextualHelp: viewModel.adjustArrowExplanation),
        const SizedBox(
          height: 40,
        ),
        ConstrainedBox(
            constraints: Constraints.aspectVisualizationConstraints,
            child: ChangeNotifierProvider(
                create: (_) => AspectVisualizationViewModel(showLabels: true, showTreatmentGoal: true),
                child: AspectVisualization(
                  onDragAndRotate: (double direction) {
                    viewModel.adaptTreatmentGoal(direction);
                  },
                ))),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
            onPressed: () => viewModel.resetTreatmentGoal(context),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(viewModel.resetLabel),
                const SizedBox(
                  width: Sizes.elevatedButtonLabelIconDistance,
                ),
                Icon(viewModel.resetIconData)
              ],
            )),
        const SizedBox(
          height: 40,
        ),
        ExplanationBox.fromContextualHelp(
          contextualHelp: viewModel.curativeExplanation,
        ),
        const SizedBox(
          height: 24,
        ),
        ExplanationBox.fromContextualHelp(
          contextualHelp: viewModel.palliativeExplanation,
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () => viewModel.onConfirmPressed(context),
          child: Text(viewModel.confirmLabel),
        ),
      ]),
    ));
  }
}
