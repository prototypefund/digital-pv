import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list.dart';
import 'package:pd_app/general/view_components/circle_painer.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect.dart';
import 'package:pd_app/general/view_components/new_aspect/treatment_activity_selection.dart';
import 'package:pd_app/general/view_components/view_helper.dart';
import 'package:pd_app/general/view_components/webview_container.dart';
import 'package:pd_app/use_cases/future_situations/future_situations_view_model.dart';
import 'package:pd_app/use_cases/future_situations/new_future_situation_view_model.dart';
import 'package:provider/provider.dart';
import 'package:webviewx/webviewx.dart';

class FutureSituations extends StatelessWidget {
  const FutureSituations({super.key});

  static Widget page({FutureSituation? focusAspect}) {
    return ChangeNotifierProvider(
        create: (_) => FutureSituationsViewModel(focusAspect: focusAspect), child: const FutureSituations());
  }

  @override
  Widget build(BuildContext context) {
    final FutureSituationsViewModel viewModel = context.watch();
    return CreationProcessNavigation<FutureSituationsViewModel>(
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
                    painter: CirclePainter(strokeColor: DefaultThemeColors.blue),
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
              child: WebViewContainer(
                title: viewModel.selectionTitle,
                editButtonTitle: viewModel.selectionEditButtonTitle,
                deleteButtonTitle: viewModel.selectionDeleteButtonTitle,
                content: viewModel.selectionContent,
                data: viewModel.futureSituationsListViewModel.aspectDataForJavascript,
                itemSelectedCallback: (item, delete) {
                  if (delete) {
                    viewModel.deleteItem(context, item);
                  } else {
                    viewModel.editItem(item);
                  }
                },
              ),
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
          if (viewModel.navigationStep == NavigationSubStep.assignTreatmentActivity)
            assignTreatmentActivity(context, viewModel),
          if (viewModel.navigationStep == NavigationSubStep.complete) ...complete(context, viewModel),
        ],
      ),
    );
  }
}

List<Widget> complete(BuildContext context, FutureSituationsViewModel viewModel) {
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

Widget editItem(BuildContext context, FutureSituationsViewModel viewModel) {
  return ChangeNotifierProvider.value(
      value: context.select((FutureSituationsViewModel viewModel) => viewModel.newFutureSituationViewModel),
      child: NewAspect<NewFutureSituationViewModel>());
}

Widget assignTreatmentActivity(BuildContext context, FutureSituationsViewModel viewModel) {
  return ChangeNotifierProvider.value(
      value: context.select((FutureSituationsViewModel viewModel) => viewModel.treatmentActivititySelectionViewModel),
      child: TreatmentActivitySelection<NewFutureSituationViewModel>());
}

Widget selectItem(BuildContext context, FutureSituationsViewModel viewModel) {
  return ChangeNotifierProvider.value(
      value: context.select((FutureSituationsViewModel viewModel) => viewModel.futureSituationsListViewModel),
      child: AspectList());
}

List<Widget> description(BuildContext context, FutureSituationsViewModel viewModel) {
  return [
    const SizedBox(height: 90),
    buildRowWithExpandedText(
      context,
      viewModel.descriptionOne,
      viewModel.explanationOne,
      color: DefaultThemeColors.darkBlue,
    ),
    const SizedBox(height: 60),
    buildRowWithExpandedText(
      context,
      viewModel.descriptionTwo,
      viewModel.explanationTwo,
      color: DefaultThemeColors.darkBlue,
    ),
  ];
}
