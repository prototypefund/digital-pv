import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/themes/constraints.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/view_components/dpv_slider.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/positive_aspects/positive_aspects_view_model.dart';
import 'package:provider/provider.dart';

class PositiveAspects extends StatelessWidget with Logging {
  PositiveAspects({super.key});

  static Widget page() {
    return ChangeNotifierProvider(create: (_) => PositiveAspectsViewModel(), child: PositiveAspects());
  }

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final PositiveAspectsViewModel viewModel = context.watch();

    return CreationProcessNavigation<PositiveAspectsViewModel>(
        widget: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Paddings.headlinePadding,
          child: Text(
            viewModel.positiveAspectsHeadlineText,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        Padding(
          padding: Paddings.headlineExplanationPadding,
          child: Text(
            viewModel.positiveAspectsExplanationText,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        if (viewModel.showNoPositiveAspectsMessage)
          Padding(
            padding: Paddings.emptyViewPadding,
            child: Text(
              viewModel.noPositiveAspectsMessageText,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          )
        else
          Padding(
              padding: Paddings.listPadding,
              child: AnimatedList(
                key: _listKey,
                shrinkWrap: true,
                initialItemCount: viewModel.positiveAspects.length,
                itemBuilder: (context, index, animation) => buildListItem(context, index, animation),
              )),
        Padding(
          padding: Paddings.callToActionPadding,
          child: ElevatedButton(
              onPressed: viewModel.addPositiveAspectCallToActionPressed(context),
              child: Text(viewModel.addPositiveAspectCallToActionText)),
        ),
      ],
    ));
  }

  Widget buildListItem(BuildContext context, int index, Animation<double> animation) {
    final PositiveAspectsViewModel viewModel = context.watch();
    final aspect = viewModel.positiveAspects[index];
    return Padding(
      key: Key(aspect.name),
      padding: Paddings.listElementPadding,
      child:
          _buildListItem(animation: animation, aspect: aspect, viewModel: viewModel, interactive: true, index: index),
    );
  }

  Widget _buildListItem(
      {required Animation<double> animation,
      required Aspect aspect,
      required PositiveAspectsViewModel viewModel,
      required bool interactive,
      required int index}) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: AspectWidget(
            aspect: aspect,
            sliderDescription: viewModel.aspectSignificanceLabel,
            sliderHighLabel: viewModel.aspectSignificanceHighLabel,
            sliderLowLabel: viewModel.aspectsSignificanceLowLabel,
            onRemove: !interactive
                ? null
                : () async {
                    logger.i('removing list item with index $index');
                    _listKey.currentState?.removeItem(
                        index,
                        (context, animation) => _buildListItem(
                            animation: animation,
                            aspect: aspect,
                            viewModel: viewModel,
                            interactive: false,
                            index: index));
                  },
            onPositionChange: !interactive
                ? null
                : (oldIndex, newIndex) {
                    _listKey.currentState?.removeItem(
                        oldIndex,
                        (context, animation) => _buildListItem(
                            animation: animation,
                            aspect: aspect,
                            viewModel: viewModel,
                            interactive: false,
                            index: index));
                    _listKey.currentState?.insertItem(newIndex);
                  }),
      ),
    );
  }
}

class AspectWidget extends StatelessWidget with Logging {
  const AspectWidget(
      {super.key,
      required this.aspect,
      required this.sliderDescription,
      required this.sliderHighLabel,
      required this.sliderLowLabel,
      this.onRemove,
      this.onPositionChange});

  final Aspect aspect;

  final String sliderDescription;
  final String sliderLowLabel;
  final String sliderHighLabel;
  final VoidCallback? onRemove;
  final void Function(int oldIndex, int newIndex)? onPositionChange;

  @override
  Widget build(BuildContext context) {
    final PositiveAspectsViewModel viewModel = context.watch();
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
                      onPressed: () async {
                        final bool didRemove = await viewModel.removeAspect(context: context, aspect: aspect);
                        if (didRemove) {
                          onRemove?.call();
                        }
                      },
                      icon: const Icon(Icons.remove_circle_outline)),
                ],
              ),
            ],
          ),
        ),
        DPVSlider(
          sliderDescription: sliderDescription,
          showLabels: viewModel.showAspectSignificanceLabel,
          sliderLowLabel: sliderLowLabel,
          sliderHighLabel: sliderHighLabel,
          value: aspect.weight.value,
          onChangeEnd: (_) {
            final AspectPositionChange positionChange = viewModel.onAspectWeightAdjustmentDone(aspect: aspect);
            if (positionChange.oldIndex != positionChange.newIndex) {
              onPositionChange?.call(positionChange.oldIndex, positionChange.newIndex);
            }
          },
          onChanged: (double value) {
            viewModel.changeAspectWeight(aspect: aspect, weight: value);
          },
        )
      ],
    );
  }
}
