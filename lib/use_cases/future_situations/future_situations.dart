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
          MarkdownBody(
              content: context.select((FutureSituationsViewModel viewModel) => viewModel.pageContent).intro ?? ''),
          ChangeNotifierProvider.value(
              value: context.select((FutureSituationsViewModel viewModel) => viewModel.futureSituationsListViewModel),
              child: AspectList(
                scrollController: viewModel.scrollController,
              )),
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
