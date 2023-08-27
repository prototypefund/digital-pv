import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list.dart';
import 'package:pd_app/general/view_components/circle_painer.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect.dart';
import 'package:pd_app/general/view_components/view_helper.dart';
import 'package:pd_app/general/view_components/webview_container.dart';
import 'package:pd_app/use_cases/negative_aspects/negative_aspects_view_model.dart';
import 'package:pd_app/use_cases/negative_aspects/new_negative_aspect_view_model.dart';
import 'package:pd_app/use_cases/positive_aspects/positive_aspects_view_model.dart';
import 'package:provider/provider.dart';
import 'package:webviewx/webviewx.dart';

class NegativeAspects extends StatelessWidget {
  const NegativeAspects({super.key});

  static Widget page({required Aspect? focusAspect}) {
    return ChangeNotifierProvider(
        create: (_) => NegativeAspectsViewModel(focusAspect: focusAspect), child: const NegativeAspects());
  }

  @override
  Widget build(BuildContext context) {
    final NegativeAspectsViewModel viewModel = context.watch<NegativeAspectsViewModel>();

    return CreationProcessNavigation<NegativeAspectsViewModel>(
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
                    painter: CirclePainter(strokeColor: DefaultThemeColors.brownGrey),
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
          Stack(alignment: Alignment.topRight, children: [
            const WebViewAware(
              child: WebViewContainer(data: """
    // Read data
    var data = [
    { value: 40, key: "Unabhängigkeit", selected: false  , show_label: false , positive: true},
    { value: 55, key: "Gesundheit", selected: false   , show_label: false, positive: true},
    { value: 33, key: "Finanzen", selected: false  , show_label: false, positive: true},
    { value: 20, key: "Freunde", selected: false   , show_label: false, positive: true},
    { value: 14, key: "Natur", selected: false  , show_label: false, positive: true},
    { value: 12, key: "Mein Hund",  selected: false   , show_label: false, positive: true},
    { value: 10, key: "Arbeit", selected: false , show_label: false, positive: true},
    { value: 83, key: "Genesung", selected: true , show_label: true, positive: true},
    { value: 83, key: "Genesung", selected: false , show_label: false, positive: false},
    { value: 13, key: "Genesung", selected: false , show_label: false, positive: false},
    { value: 23, key: "Genesung", selected: true , show_label: true, positive: false},
    { value: 55, key: "Gesundheit", selected: false   , show_label: false, positive: false},
]; 
"""),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildText(viewModel.visualizationNegativeTitle, context, textColor: DefaultThemeColors.brownGrey),
            ),
          ]),
          const SizedBox(
            height: 120,
          ),
          if (viewModel.navigationStep == NavigationSubStep.description) ...description(context, viewModel),
          if (viewModel.navigationStep == NavigationSubStep.select) selectItem(context, viewModel),
          if (viewModel.navigationStep == NavigationSubStep.edit) editItem(context, viewModel),
          if (viewModel.navigationStep == NavigationSubStep.complete) ...complete(context, viewModel),
        ],
      ),
    );
  }

  Widget editItem(BuildContext context, NegativeAspectsViewModel viewModel) {
    return ChangeNotifierProvider.value(
        value: context.select((NegativeAspectsViewModel viewModel) => viewModel.newNegativeAspectViewModel),
        child: NewAspect<NewNegativeAspectViewModel>());
  }

  List<Widget> description(BuildContext context, NegativeAspectsViewModel viewModel) {
    return [
      const SizedBox(height: 90),
      buildRowWithExpandedText(context, viewModel.descriptionOne, viewModel.explanationOne,
          color: DefaultThemeColors.brownGrey),
      const SizedBox(height: 60),
      buildRowWithExpandedText(context, viewModel.descriptionTwo, viewModel.explanationTwo,
          color: DefaultThemeColors.brownGrey),
    ];
  }

  List<Widget> complete(BuildContext context, NegativeAspectsViewModel viewModel) {
    return [
      const SizedBox(height: 90),
      buildRowWithExpandedText(context, viewModel.completeDescriptionOne, viewModel.completeExplanationOne,
          color: DefaultThemeColors.brownGrey),
      const SizedBox(height: 60),
      buildRowWithExpandedText(context, viewModel.completeDescriptionTwo, viewModel.completeExplanationTwo,
          color: DefaultThemeColors.brownGrey),
    ];
  }

  Widget selectItem(BuildContext context, NegativeAspectsViewModel viewModel) {
    return ChangeNotifierProvider.value(
        value: context.select((NegativeAspectsViewModel viewModel) => viewModel.negativeAspectsListViewModel),
        child: AspectList());
  }
}
