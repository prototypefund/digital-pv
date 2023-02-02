import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/themes/paddings.dart';
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
          Padding(
            padding: Paddings.headlinePadding,
            child: Text(
              context.select((PositiveAspectsViewModel viewModel) => viewModel.positiveAspectsHeadlineText),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Padding(
            padding: Paddings.headlineExplanationPadding,
            child: Text(
              context.select((PositiveAspectsViewModel viewModel) => viewModel.positiveAspectsExplanationText),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          ChangeNotifierProvider.value(
              value: context.select((PositiveAspectsViewModel viewModel) => viewModel.positiveAspectListViewModel),
              child: AspectList())
        ],
      ),
    );
  }
}
