import 'package:flutter/material.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/themes/constraints.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/view_components/dpv_slider.dart';
import 'package:pd_app/logging.dart';
import 'package:provider/provider.dart';

import 'aspect_list_view_model.dart';

class AspectList extends StatelessWidget with Logging {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  AspectList({super.key});

  @override
  Widget build(BuildContext context) {
    final AspectListViewModel _viewModel = context.watch();
    return Column(
      children: [
        if (_viewModel.showEmptyAspectListsMessage)
          Padding(
            padding: Paddings.emptyViewPadding,
            child: Text(
              _viewModel.emptyAspectListsMessageText,
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
                initialItemCount: _viewModel.aspects.length,
                itemBuilder: (context, index, animation) => buildListItem(context, index, animation),
              )),
        Padding(
          padding: Paddings.callToActionPadding,
          child: ElevatedButton(
              onPressed: _viewModel.addAspectCallToActionPressed(context),
              child: Text(_viewModel.addAspectCallToActionText)),
        ),
      ],
    );
  }

  Widget buildListItem(BuildContext context, int index, Animation<double> animation) {
    final AspectListViewModel _viewModel = context.watch();
    final aspect = _viewModel.aspects[index];
    return Padding(
      key: Key(aspect.name),
      padding: Paddings.listElementPadding,
      child:
          _buildListItem(animation: animation, aspect: aspect, viewModel: _viewModel, interactive: true, index: index),
    );
  }

  Widget _buildListItem(
      {required Animation<double> animation,
      required Aspect aspect,
      required AspectListViewModel viewModel,
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
                    logger.d('position change, from $oldIndex to $newIndex');
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
      {Key? key,
      required this.aspect,
      required this.sliderDescription,
      required this.sliderHighLabel,
      required this.sliderLowLabel,
      this.onRemove,
      this.onPositionChange})
      : super(key: key);

  final Aspect aspect;

  final String sliderDescription;
  final String sliderLowLabel;
  final String sliderHighLabel;
  final VoidCallback? onRemove;
  final void Function(int oldIndex, int newIndex)? onPositionChange;

  @override
  Widget build(BuildContext context) {
    final AspectListViewModel _viewModel = context.watch();
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
                        final bool didRemove = await _viewModel.removeAspect(context: context, aspect: aspect);
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
          showLabels: _viewModel.showAspectSignificanceLabel,
          sliderLowLabel: sliderLowLabel,
          sliderHighLabel: sliderHighLabel,
          value: aspect.weight.value,
          onChangeEnd: (_) {
            final AspectPositionChange positionChange = _viewModel.onAspectWeightAdjustmentDone(aspect: aspect);
            if (positionChange.oldIndex != positionChange.newIndex) {
              onPositionChange?.call(positionChange.oldIndex, positionChange.newIndex);
            }
          },
          onChanged: (double value) {
            _viewModel.changeAspectWeight(aspect: aspect, weight: value);
          },
        )
      ],
    );
  }
}
