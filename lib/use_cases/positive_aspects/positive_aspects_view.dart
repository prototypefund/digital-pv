import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/themes/constraints.dart';
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
        if (_viewModel.showNoPositiveAspectsMessage)
          Padding(
            padding: Paddings.emptyViewPadding,
            child: Text(
              _viewModel.noPositiveAspectsMessageText,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          )
        else
          Padding(
              padding: Paddings.listPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _viewModel.positiveAspects
                    .map((positiveAspect) => Padding(
                          padding: Paddings.listElementPadding,
                          child: AspectWidget(
                            aspect: positiveAspect,
                            sliderDescription: _viewModel.positiveAspectsSignificanceLabel,
                            sliderHighLabel: _viewModel.positiveAspectsSignificanceHighLabel,
                            sliderLowLabel: _viewModel.positiveAspectsSignificanceLowLabel,
                          ),
                        ))
                    .toList(),
              )),
        Padding(
          padding: Paddings.callToActionPadding,
          child: ElevatedButton(
              onPressed: _viewModel.addPositiveAspectCallToActionPressed(context),
              child: Text(_viewModel.addPositiveAspectCallToActionText)),
        ),
      ],
    ));
  }
}

class AspectWidget extends StatelessWidget {
  const AspectWidget(
      {Key? key,
      required this.aspect,
      required this.sliderDescription,
      required this.sliderHighLabel,
      required this.sliderLowLabel})
      : super(key: key);

  final Aspect aspect;

  final String sliderDescription;
  final String sliderLowLabel;
  final String sliderHighLabel;

  @override
  Widget build(BuildContext context) {
    final PositiveAspectsViewModel _viewModel = context.watch();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: Constraints.aspectTitleConstraints,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  aspect.name,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => _viewModel.removeAspect(aspect: aspect),
                      icon: const Icon(Icons.remove_circle_outline)),
                ],
              ),
            ],
          ),
        ),
        Container(
          constraints: Constraints.sliderConstraints,
          padding: Paddings.sliderPadding,
          child: Column(
            children: [
              if (_viewModel.showPositiveAspectsSignificanceLabel)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      sliderDescription,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              Slider(
                value: aspect.weight.value,
                onChanged: (double value) {
                  _viewModel.changeAspectWeight(aspect: aspect, weight: value);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      sliderLowLabel,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      sliderHighLabel,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [],
              )
            ],
          ),
        )
      ],
    );
  }
}
