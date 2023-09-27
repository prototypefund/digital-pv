import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/markdown/markdown_body.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect.dart';
import 'package:pd_app/use_cases/future_situations/future_situations_view_model.dart';
import 'package:pd_app/use_cases/future_situations/new_future_situation_view_model.dart';
import 'package:provider/provider.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
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
            height: 20,
          ),
          ChangeNotifierProvider.value(
              value: viewModel.newFutureSituationViewModel, child: NewAspect<NewFutureSituationViewModel>()),
          const SizedBox(
            height: 20,
          ),
          MarkdownBody(
              content: context.select((FutureSituationsViewModel viewModel) => viewModel.pageContent).outro ?? ''),
        ],
      ),
    );
  }
}
