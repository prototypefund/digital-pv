import 'package:flutter/material.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/general/view_components/aspect_widget/aspect_widget.dart';
import 'package:pd_app/logging.dart';
import 'package:provider/provider.dart';

class AspectList<AspectType extends Aspect> extends StatelessWidget with Logging {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  AspectList({super.key});

  @override
  Widget build(BuildContext context) {
    final AspectListViewModel<AspectType> viewModel = context.watch();

    viewModel.onAspectAdded = (AspectType newAspect) {
      logger.d('adding new aspect to existing list in an animated way');
      final int index = viewModel.aspects.indexOf(newAspect);
      _listKey.currentState?.insertItem(index);
    };

    viewModel.onAspectRemoved = (AspectType removedAspect) {
      logger.d('removing removed aspect in an animated way');
      final int oldIndex = viewModel.aspects.indexOf(removedAspect);
      _listKey.currentState?.removeItem(
          oldIndex,
          (context, animation) => _buildListItem(
              animation: animation, aspect: removedAspect, viewModel: viewModel, interactive: false, index: oldIndex));
    };

    return Column(
      children: [
        if (viewModel.showEmptyAspectListsMessage)
          Padding(
            padding: Paddings.emptyViewPadding,
            child: Text(
              viewModel.emptyAspectListsMessageText,
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
                physics: const NeverScrollableScrollPhysics(),
                initialItemCount: viewModel.aspects.length,
                itemBuilder: (context, index, animation) => buildListItem(context, index, animation),
              )),
      ],
    );
  }

  Widget buildListItem(BuildContext context, int index, Animation<double> animation) {
    final AspectListViewModel<AspectType> viewModel = context.watch();
    final AspectType aspect = viewModel.aspects[index];
    return Padding(
      key: Key(aspect.name),
      padding: Paddings.listElementPadding,
      child:
          _buildListItem(animation: animation, aspect: aspect, viewModel: viewModel, interactive: true, index: index),
    );
  }

  Widget _buildListItem(
      {required Animation<double> animation,
      required AspectType aspect,
      required AspectListViewModel viewModel,
      required bool interactive,
      required int index}) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: AspectWidget<AspectType>(
            aspect: aspect,
            sliderDescription: '',
            sliderHighLabel: viewModel.aspectSignificanceHighLabel,
            sliderLowLabel: viewModel.aspectsSignificanceLowLabel,
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
