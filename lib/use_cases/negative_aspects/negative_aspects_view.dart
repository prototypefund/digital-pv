import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect.dart';
import 'package:pd_app/use_cases/negative_aspects/negative_aspects_view_model.dart';
import 'package:pd_app/use_cases/negative_aspects/new_negative_aspect_view_model.dart';
import 'package:provider/provider.dart';

class NegativeAspects extends StatelessWidget {
  const NegativeAspects({super.key});

  static Widget page() {
    return ChangeNotifierProvider(create: (_) => NegativeAspectsViewModel(), child: const NegativeAspects());
  }

  @override
  Widget build(BuildContext context) {
    final NegativeAspectsViewModel viewModel = context.watch<NegativeAspectsViewModel>();

    return CreationProcessNavigation<NegativeAspectsViewModel>(
        widget: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Paddings.headlinePadding,
          child: Text(viewModel.negativeAspectsTitle, style: Theme.of(context).textTheme.headlineSmall),
        ),
        Padding(
          padding: Paddings.headlineExplanationPadding,
          child: Text(
            viewModel.negativeAspectsTitleExplanation,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        ChangeNotifierProvider.value(
            value: context.select((NegativeAspectsViewModel viewModel) => viewModel.negativeAspectsListViewModel),
            child: AspectList()),
        const SizedBox(
          height: 20,
        ),
        ChangeNotifierProvider.value(
            value: viewModel.newNegativeAspectViewModel, child: NewAspect<NewNegativeAspectViewModel>())
      ],
    ));
  }
}
