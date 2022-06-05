import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/use_cases/positive_aspects/positive_aspects_view_model.dart';
import 'package:provider/provider.dart';

class PositiveAspects extends StatelessWidget {
  const PositiveAspects({Key? key}) : super(key: key);

  static Widget page() {
    return ChangeNotifierProvider(create: (_) => PositiveAspectsViewModel(), child: const PositiveAspects());
  }

  @override
  Widget build(BuildContext context) {
    final PositiveAspectsViewModel _viewModel = context.watch();

    return CreationProcessNavigation<PositiveAspectsViewModel>(
        widget: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Paddings.headlinePadding,
          child: Text(
            _viewModel.positiveAspectsHeadlineText,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        Padding(
          padding: Paddings.headlineExplanationPadding,
          child: Text(
            _viewModel.positiveAspectsExplanationText,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Padding(
          padding: Paddings.emptyViewPadding,
          child: Text(
            _viewModel.noPositiveAspectsMessageText,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Padding(
          padding: Paddings.callToActionPadding,
          child: ElevatedButton(
              onPressed: _viewModel.addPositiveAspectCallToActionPressed,
              child: Text(_viewModel.addPositiveAspectCallToActionText)),
        ),
        SizedBox(
          height: 500,
        )
      ],
    ));
  }
}
