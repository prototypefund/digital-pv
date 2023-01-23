import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/themes/constraints.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/view_components/aspect_visualization/aspect_visualization.dart';
import 'package:pd_app/general/view_components/aspect_visualization/aspect_visualization_view_model.dart';
import 'package:pd_app/use_cases/evaluate_current_aspects/evaluate_current_aspects_view_model.dart';
import 'package:provider/provider.dart';

class EvaluateCurrentAspects extends StatelessWidget {
  const EvaluateCurrentAspects({Key? key}) : super(key: key);

  static Widget page() {
    return ChangeNotifierProvider(
        create: (_) => EvaluateCurrentAspectsViewModel(), child: const EvaluateCurrentAspects());
  }

  @override
  Widget build(BuildContext context) {
    final EvaluateCurrentAspectsViewModel _viewModel = context.watch();
    return CreationProcessNavigation<EvaluateCurrentAspectsViewModel>(
        widget: SizedBox(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: Paddings.headlinePadding,
          child: Text(_viewModel.headline, style: Theme.of(context).textTheme.headlineSmall),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          _viewModel.summary,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 40,
        ),
        ConstrainedBox(
            constraints: Constraints.aspectVisualizationConstraints,
            child: ChangeNotifierProvider(
                create: (_) => AspectVisualizationViewModel(showLabels: true, showTreatmentGoal: false),
                child: const AspectVisualization())),
        const SizedBox(
          height: 24,
        ),
        Text(
          _viewModel.confirmEvaluationQuestion,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          onPressed: () => _viewModel.onConfirmPressed(context),
          child: Text(_viewModel.confirmEvaluation),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          _viewModel.changeAspectsIfNoMatchCallToAction,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        )
      ]),
    ));
  }
}
