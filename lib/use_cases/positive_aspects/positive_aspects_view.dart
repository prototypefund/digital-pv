import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/markdown/markdown_body.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/positive_aspects/positive_aspects_view_model.dart';
import 'package:provider/provider.dart';

class PositiveAspects extends StatelessWidget with Logging {
  PositiveAspects({Key? key}) : super(key: key);

  static Widget page() {
    return ChangeNotifierProvider(create: (_) => PositiveAspectsViewModel(), child: PositiveAspects());
  }

  @override
  Widget build(BuildContext context) {
    return CreationProcessNavigation<PositiveAspectsViewModel>(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarkdownBody(
              content: context.select((PositiveAspectsViewModel viewModel) => viewModel.pageContent).intro ?? ''),
          ChangeNotifierProvider.value(
              value: context.select((PositiveAspectsViewModel viewModel) => viewModel.positiveAspectListViewModel),
              child: AspectList()),
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
