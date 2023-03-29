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
    final PositiveAspectsViewModel viewModel = context.watch();
    return CreationProcessNavigation<PositiveAspectsViewModel>(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarkdownBody(
              content: context.select((PositiveAspectsViewModel viewModel) => viewModel.pageContent).intro ?? ''),
          ChangeNotifierProvider.value(
              value: context.select((PositiveAspectsViewModel viewModel) => viewModel.positiveAspectListViewModel),
              child: AspectList(
                scrollController: viewModel.scrollController,
              )),
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
