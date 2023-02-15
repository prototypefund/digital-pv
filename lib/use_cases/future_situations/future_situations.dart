import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect.dart';
import 'package:pd_app/use_cases/future_situations/future_situations_view_model.dart';
import 'package:pd_app/use_cases/future_situations/new_future_situation_view_model.dart';
import 'package:provider/provider.dart';

class FutureSituations extends StatelessWidget {
  const FutureSituations({super.key});

  static Widget page() {
    return ChangeNotifierProvider(create: (_) => FutureSituationsViewModel(), child: const FutureSituations());
  }

  @override
  Widget build(BuildContext context) {
    final FutureSituationsViewModel viewModel = context.watch();

    return CreationProcessNavigation<FutureSituationsViewModel>(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: Paddings.headlinePadding,
            child: Text(viewModel.futureSituationsTitle, style: Theme.of(context).textTheme.headlineSmall),
          ),
          Padding(
            padding: Paddings.headlineExplanationPadding,
            child: Text(
              viewModel.futureSituationsTitleExplanation,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          ChangeNotifierProvider.value(
              value: context.select((FutureSituationsViewModel viewModel) => viewModel.futureSituationsListViewModel),
              child: AspectList()),
          const SizedBox(
            height: 20,
          ),
          ChangeNotifierProvider.value(
              value: viewModel.newFutureSituationViewModel, child: NewAspect<NewFutureSituationViewModel>())
        ],
      ),
    );
  }
}
