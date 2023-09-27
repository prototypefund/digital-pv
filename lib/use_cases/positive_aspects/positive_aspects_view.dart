import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/markdown/markdown_body.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/positive_aspects/new_positive_aspect_view_model.dart';
import 'package:pd_app/use_cases/positive_aspects/positive_aspects_view_model.dart';
import 'package:provider/provider.dart';

class PositiveAspects extends StatelessWidget with Logging {
  PositiveAspects({super.key});

  static Widget page({required Aspect? focusAspect}) {
    return ChangeNotifierProvider(
        create: (_) => PositiveAspectsViewModel(focusAspect: focusAspect), child: PositiveAspects());
  }

  @override
  Widget build(BuildContext context) {
    return CreationProcessNavigation<PositiveAspectsViewModel>(
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
              child: WebViewContainer(
                title: viewModel.selectionTitle,
                editButtonTitle: viewModel.selectionEditButtonTitle,
                deleteButtonTitle: viewModel.selectionDeleteButtonTitle,
                content: viewModel.selectionContent,
                data: viewModel.positiveAspectListViewModel.aspectDataForJavascript,
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
              value: context.select((PositiveAspectsViewModel viewModel) => viewModel.newPositiveAspectViewModel),
              child: NewAspect<NewPositiveAspectViewModel>()),
          const SizedBox(
            height: 24,
          ),
          MarkdownBody(
              content: context.select((PositiveAspectsViewModel viewModel) => viewModel.pageContent).outro ?? ''),
        ],
      ),
    );
  }
}
