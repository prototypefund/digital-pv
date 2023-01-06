import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect.dart';
import 'package:pd_app/use_cases/future_situations/future_situations_view_model.dart';
import 'package:pd_app/use_cases/future_situations/new_future_situation_view_model.dart';
import 'package:provider/provider.dart';

class FutureSituations extends StatelessWidget {
  const FutureSituations({Key? key}) : super(key: key);

  static Widget page() {
    return ChangeNotifierProvider(create: (_) => FutureSituationsViewModel(), child: const FutureSituations());
  }

  @override
  Widget build(BuildContext context) {
    final FutureSituationsViewModel _viewModel = context.watch();

    return CreationProcessNavigation<FutureSituationsViewModel>(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: Paddings.headlinePadding,
            child: Text(_viewModel.futureSituationsTitle, style: Theme.of(context).textTheme.headlineLarge),
          ),
          Padding(
            padding: Paddings.headlineExplanationPadding,
            child: Text(
              _viewModel.futureSituationsTitleExplanation,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          ChangeNotifierProvider.value(
              value: context.select((FutureSituationsViewModel viewModel) => viewModel.futureSituationsListViewModel),
              child: AspectList()),
          SizedBox(
            height: 20,
          ),
          ChangeNotifierProvider.value(
              value: _viewModel.newFutureSituationViewModel, child: NewAspect<NewFutureSituationViewModel>())
        ],
      ),
    );
  }
}
