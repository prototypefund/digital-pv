import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/markdown/markdown_body.dart';
import 'package:pd_app/general/themes/constraints.dart';
import 'package:pd_app/general/view_components/directive_visualization/directive_visualization.dart';
import 'package:pd_app/general/view_components/directive_visualization/directive_visualization_view_model.dart';
import 'package:pd_app/use_cases/evaluate_current_aspects/evaluate_current_aspects_view_model.dart';
import 'package:provider/provider.dart';

class EvaluateCurrentAspects extends StatelessWidget {
  const EvaluateCurrentAspects({super.key});

  static Widget page() {
    return ChangeNotifierProvider(
        create: (_) => EvaluateCurrentAspectsViewModel(), child: const EvaluateCurrentAspects());
  }

  @override
  Widget build(BuildContext context) {
    final EvaluateCurrentAspectsViewModel viewModel = context.watch();
    return CreationProcessNavigation<EvaluateCurrentAspectsViewModel>(
        widget: SizedBox(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        MarkdownBody(
            content: context.select((EvaluateCurrentAspectsViewModel viewModel) => viewModel.pageContent).intro,
            textAlignment: WrapAlignment.center),
        const SizedBox(
          height: 24,
        ),
        MarkdownBody(
            content: context.select((EvaluateCurrentAspectsViewModel viewModel) => viewModel.showPositiveSummary
                ? viewModel.pageContent.positiveQualityOfLifeExplanation
                : viewModel.pageContent.negativeQualityOfLifeExplanation),
            textAlignment: WrapAlignment.center),
        const SizedBox(
          height: 40,
        ),
        ConstrainedBox(
            constraints: Constraints.aspectVisualizationConstraints,
            child: ChangeNotifierProvider(
                create: (_) => DirectiveVisualizationViewModel(showLabels: true, showTreatmentGoal: false),
                child: const DirectiveVisualization())),
        const SizedBox(
          height: 24,
        ),
        MarkdownBody(
            content: context
                .select((EvaluateCurrentAspectsViewModel viewModel) => viewModel.pageContent)
                .confirmationQuestion,
            textAlignment: WrapAlignment.center),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () => viewModel.onConfirmPressed(context),
          child: Text(viewModel.pageContent.confirmActionLabel),
        ),
        const SizedBox(
          height: 24,
        ),
        MarkdownBody(
          content: context.select((EvaluateCurrentAspectsViewModel viewModel) => viewModel.pageContent).outro ?? '',
          textAlignment: WrapAlignment.center,
        )
      ]),
    ));
  }
}
