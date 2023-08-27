import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/view_components/circle_painer.dart';
import 'package:pd_app/general/view_components/dpv_wrapped_box_checkbox.dart';
import 'package:pd_app/general/view_components/webview_gauge_container.dart';
import 'package:pd_app/use_cases/general_treatment_objective/general_treatment_objective_view_model.dart';
import 'package:provider/provider.dart';

class GeneralTreatmentObjective extends StatelessWidget {
  const GeneralTreatmentObjective({super.key});

  static Widget page() {
    return ChangeNotifierProvider(
        create: (_) => GeneralTreatmentObjectiveViewModel(), child: const GeneralTreatmentObjective());
  }

  Widget buildText(String text, BuildContext context, TextStyle style) {
    return Text(text, textAlign: TextAlign.left, style: style);
  }

  Widget buildCenterText(String text, BuildContext context, TextStyle style) {
    return Center(child: MarkdownBody(data: text));
  }

  @override
  Widget build(BuildContext context) {
    final GeneralTreatmentObjectiveViewModel viewModel = context.watch();
    return CreationProcessNavigation<GeneralTreatmentObjectiveViewModel>(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  left: 55.0,
                  top: 65,
                  child: CustomPaint(
                    painter: CirclePainter(
                        strokeColor:
                            viewModel.showPositiveSummary ? DefaultThemeColors.cyan : DefaultThemeColors.brownGrey),
                  )),
              buildText(viewModel.title, context, Theme.of(context).textTheme.headlineMedium!),
            ],
          ),
          buildText(viewModel.subtopic, context, Theme.of(context).textTheme.titleSmall!),
          const SizedBox(height: 120),
          buildCenterText(viewModel.visualizationTitle, context, Theme.of(context).textTheme.headlineSmall!),
          WebGaugeViewContainer(value: viewModel.generalTreatmentGoalScore == 1 ? 0.0 : 1.0),
          DPVWrappedBoxCheckbox(
            height: 261,
            title: viewModel.expectationMatch,
            description: viewModel.expectationMatchDescription,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            value: viewModel.expectationMatchSelected,
            onChanged: (bool? value) {
              viewModel.expectationMatchSelected = !viewModel.expectationMatchSelected;
            },
          ),
          const SizedBox(height: 40),
          DPVWrappedBoxCheckbox(
            height: 261,
            description: viewModel.expectationMismatchDescription,
            title: viewModel.expectationMismatch,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            value: viewModel.expectationMismatchSelected,
            onChanged: (bool? value) {
              viewModel.expectationMismatchSelected = !viewModel.expectationMismatchSelected;
            },
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
