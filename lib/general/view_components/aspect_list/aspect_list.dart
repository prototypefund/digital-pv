import 'package:flutter/material.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/model/future_situation.dart';
import 'package:pd_app/general/themes/constraints.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/themes/thresholds.dart';
import 'package:pd_app/general/treatment_activities/treatment_activities_selection_view.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/general/view_components/dpv_box.dart';
import 'package:pd_app/general/view_components/dpv_slider.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/future_situations/future_situation_treatment_activities_selection_view_model.dart';
import 'package:provider/provider.dart';

class AspectList<AspectType extends Aspect> extends StatelessWidget with Logging {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  AspectList({super.key});

  @override
  Widget build(BuildContext context) {
    final AspectListViewModel<AspectType> _viewModel = context.watch();

    _viewModel.onAspectAdded = (AspectType newAspect) {
      logger.d('adding new aspect to existing list in an animated way');
      final int index = _viewModel.aspects.indexOf(newAspect);
      _listKey.currentState?.insertItem(index);
    };

    _viewModel.onAspectRemoved = (AspectType removedAspect) {
      logger.d('removing removed aspect in an animated way');
      final int oldIndex = _viewModel.aspects.indexOf(removedAspect);
      _listKey.currentState?.removeItem(
          oldIndex,
          (context, animation) => _buildListItem(
              animation: animation, aspect: removedAspect, viewModel: _viewModel, interactive: false, index: oldIndex));
    };

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
                physics: const NeverScrollableScrollPhysics(),
                initialItemCount: _viewModel.aspects.length,
                itemBuilder: (context, index, animation) => buildListItem(context, index, animation),
              )),
        if (_viewModel.showAddAspectCallToAction)
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
    final AspectListViewModel<AspectType> _viewModel = context.watch();
    final AspectType aspect = _viewModel.aspects[index];
    return Padding(
      key: Key(aspect.name),
      padding: Paddings.listElementPadding,
      child:
          _buildListItem(animation: animation, aspect: aspect, viewModel: _viewModel, interactive: true, index: index),
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
            sliderDescription: viewModel.aspectSignificanceLabel,
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

class AspectWidget<AspectType extends Aspect> extends StatelessWidget with Logging {
  const AspectWidget(
      {Key? key,
      required this.aspect,
      required this.sliderDescription,
      required this.sliderHighLabel,
      required this.sliderLowLabel,
      this.onRemove,
      this.onPositionChange})
      : super(key: key);

  final AspectType aspect;

  final String sliderDescription;
  final String sliderLowLabel;
  final String sliderHighLabel;
  final VoidCallback? onRemove;
  final void Function(int oldIndex, int newIndex)? onPositionChange;

  @override
  Widget build(BuildContext context) {
    final AspectListViewModel _viewModel = context.watch();
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    if (mediaQuery.size.width < Thresholds.futureSituationsTwoColumnDisplayThreshold) {
      return _buildSmallScreenVersion(context, _viewModel);
    } else {
      return _buildLargeScreenVersion(context, _viewModel);
    }
  }

  DPVBox _buildSmallScreenVersion(BuildContext context, AspectListViewModel _viewModel) {
    return DPVBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSliderWithDescription(context: context, viewModel: _viewModel),
          if (_viewModel.showTreatmentOptions)
            _buildTreatmentOptionsWidget(context: context, viewModel: _viewModel, aspect: aspect)
        ],
      ),
    );
  }

  DPVBox _buildLargeScreenVersion(BuildContext context, AspectListViewModel _viewModel) {
    return DPVBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(flex: 5, child: _buildSliderWithDescription(context: context, viewModel: _viewModel)),
          if (_viewModel.showTreatmentOptions)
            const Flexible(
              flex: 1,
              child: SizedBox.shrink(),
            ),
          if (_viewModel.showTreatmentOptions)
            Flexible(
                flex: 5, child: _buildTreatmentOptionsWidget(context: context, viewModel: _viewModel, aspect: aspect))
        ],
      ),
    );
  }

  Widget _buildSliderWithDescription({required BuildContext context, required AspectListViewModel viewModel}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        ),
      ],
    );
  }

  Widget _buildTreatmentOptionsWidget(
      {required BuildContext context, required AspectListViewModel viewModel, required AspectType aspect}) {
    if (aspect is FutureSituation) {
      return ChangeNotifierProvider(
          create: (_) => FutureSituationTreatmentActivitiesSelectionViewModel(futureSituation: aspect),
          child: TreatmentActivitiesSelection<FutureSituationTreatmentActivitiesSelectionViewModel>());
    } else {
      return const SizedBox.shrink();
    }
  }
}
