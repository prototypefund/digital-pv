import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list.dart';
import 'package:pd_app/general/view_components/circle_painer.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect.dart';
import 'package:pd_app/general/view_components/view_helper.dart';
import 'package:pd_app/general/view_components/webview_container.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/positive_aspects/new_positive_aspect_view_model.dart';
import 'package:pd_app/use_cases/positive_aspects/positive_aspects_view_model.dart';
import 'package:provider/provider.dart';
import 'package:webviewx/webviewx.dart';

class PositiveAspects extends StatelessWidget with Logging {
  PositiveAspects({super.key});

  static Widget page({required Aspect? focusAspect}) {
    return ChangeNotifierProvider(
        create: (_) => PositiveAspectsViewModel(focusAspect: focusAspect), child: PositiveAspects());
  }

  @override
  Widget build(BuildContext context) {
    final PositiveAspectsViewModel viewModel = context.watch();
    return CreationProcessNavigation<PositiveAspectsViewModel>(
      widget: Column(
        children: [
          buildCenterText(
            viewModel.subtitle,
            context,
          ),
          const SizedBox(height: 80),
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  left: 55.0,
                  top: 20,
                  child: CustomPaint(
                    painter: CirclePainter(strokeColor: DefaultThemeColors.cyan),
                  )),
              buildText(
                viewModel.title,
                context,
              ),
            ],
          ),
          buildText(viewModel.subtopic, context),
          const SizedBox(height: 120),
          buildCenterText(
            viewModel.visualizationTitle,
            context,
          ),
          Stack(children: [
            WebViewAware(
              child: WebViewContainer(data: viewModel.positiveAspectListViewModel.aspectDataForJavascript),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildText(viewModel.visualizationPositiveTitle, context, textColor: DefaultThemeColors.cyan),
            ),
          ]),
          const SizedBox(
            height: 120,
          ),
          if (viewModel.navigationStep == NavigationSubStep.description) ...description(context, viewModel),
          if (viewModel.navigationStep == NavigationSubStep.select) selectItem(context, viewModel),
          if (viewModel.navigationStep == NavigationSubStep.edit) editItem(context, viewModel),
          if (viewModel.navigationStep == NavigationSubStep.complete) ...complete(context, viewModel),
          // if (viewModel.positiveAspectListViewModel.aspects.isNotEmpty)
          //   DPVNextPageButton(
          //     inverted: true,
          //     alignment: Alignment.center,
          //     title: viewModel.nextButtonText,
          //     canProceed: viewModel.nextButtonEnabled,
          //     onPressed: viewModel.nextButtonEnabled ? () => viewModel.onNextButtonPressed(context) : () {},
          //   ),
        ],
      ),
    );
  }

  Widget editItem(BuildContext context, PositiveAspectsViewModel viewModel) {
    return ChangeNotifierProvider.value(
        value: context.select((PositiveAspectsViewModel viewModel) => viewModel.newPositiveAspectViewModel),
        child: NewAspect<NewPositiveAspectViewModel>());
  }

  List<Widget> description(BuildContext context, PositiveAspectsViewModel viewModel) {
    return [
      const SizedBox(height: 90),
      buildRowWithExpandedText(
        context,
        viewModel.descriptionOne,
        viewModel.explanationOne,
      ),
      const SizedBox(height: 60),
      buildRowWithExpandedText(
        context,
        viewModel.descriptionTwo,
        viewModel.explanationTwo,
      ),
    ];
  }

  List<Widget> complete(BuildContext context, PositiveAspectsViewModel viewModel) {
    return [
      const SizedBox(height: 90),
      buildRowWithExpandedText(
        context,
        viewModel.completeDescriptionOne,
        viewModel.completeExplanationOne,
      ),
      const SizedBox(height: 60),
      buildRowWithExpandedText(
        context,
        viewModel.completeDescriptionTwo,
        viewModel.completeExplanationTwo,
      ),
    ];
  }

  Widget selectItem(BuildContext context, PositiveAspectsViewModel viewModel) {
    return ChangeNotifierProvider.value(
        value: context.select((PositiveAspectsViewModel viewModel) => viewModel.positiveAspectListViewModel),
        child: AspectList());
  }
}
