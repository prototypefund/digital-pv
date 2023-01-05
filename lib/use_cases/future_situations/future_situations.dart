import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/themes/constraints.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/view_components/aspect_examples/aspect_examples.dart';
import 'package:pd_app/general/view_components/dpv_box.dart';
import 'package:pd_app/general/view_components/dpv_slider.dart';
import 'package:pd_app/logging.dart';
import 'package:pd_app/use_cases/future_situations/future_situations_view_model.dart';
import 'package:provider/provider.dart';

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
    final FutureSituationsViewModel _viewModel = context.watch();
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

class AspectPositionChange {
  AspectPositionChange({required this.oldIndex, required this.newIndex});

  final int oldIndex;
  final int newIndex;
}

class FutureSituations extends StatefulWidget {
  const FutureSituations({Key? key}) : super(key: key);

  static Widget page() {
    return ChangeNotifierProvider(create: (_) => FutureSituationsViewModel(), child: const FutureSituations());
  }

  @override
  State<FutureSituations> createState() => _FutureSituationsState();
}

class _FutureSituationsState extends State<FutureSituations> with SingleTickerProviderStateMixin, Logging {
  late final TabController _controller;
  late FutureSituationsViewModel _viewModel;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    // Duration.zero resulted in issues
    _controller = TabController(length: 3, vsync: this, animationDuration: const Duration(milliseconds: 1));
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _viewModel = context.watch();
    _viewModel.listKey = _listKey;
  }

  Widget _buildListItem(
      {required Animation<double> animation,
      required Aspect aspect,
      required FutureSituationsViewModel viewModel,
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

                    _viewModel.removeItem(
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
                    _viewModel.removeItem(
                        index,
                        (context, animation) => _buildListItem(
                            animation: animation,
                            aspect: aspect,
                            viewModel: viewModel,
                            interactive: false,
                            index: index));
                    // _listKey.currentState?.insertItem(newIndex);
                    _viewModel.addFutureSituationAspect(context);
                  }),
      ),
    );
  }

  Widget buildListItem(BuildContext context, int index, Animation<double> animation) {
    final aspect = _viewModel.futureSituationAspects[index];

    return Padding(
      key: Key(aspect.name),
      padding: Paddings.listElementPadding,
      child:
          _buildListItem(animation: animation, aspect: aspect, viewModel: _viewModel, interactive: true, index: index),
    );
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch();

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
          DPVBox(
            child: _viewModel.showNoFutureSituationAspectsMessage == true
                ? Padding(
                    padding: Paddings.emptyViewPadding,
                    child: Text(
                      _viewModel.noFutureSituationAspectsMessageText,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                : Padding(
                    padding: Paddings.listPadding,
                    child: AnimatedList(
                      key: _listKey,
                      shrinkWrap: true,
                      initialItemCount: _viewModel.futureSituationAspects.length,
                      itemBuilder: (context, index, animation) => buildListItem(context, index, animation),
                    )),
          ),
          DPVBox(
            child: Column(
              children: [
                Padding(
                  padding: Paddings.textFieldPadding,
                  child: TextField(
                    controller: _viewModel.aspectTextFieldController,
                    onChanged: (newValue) => setState(() {}),
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(hintText: _viewModel.addFutureSituationAspectTextfieldHint),
                    autofocus: true,
                  ),
                ),
                DPVSlider(
                  sliderDescription: _viewModel.aspectSignificanceLabel,
                  showLabels: _viewModel.showAspectSignificanceLabel,
                  sliderLowLabel: _viewModel.aspectsSignificanceLowLabel,
                  sliderHighLabel: _viewModel.aspectSignificanceHighLabel,
                  value: _viewModel.weight,
                  padding: Paddings.newAspectSliderPadding,
                  onChanged: (double value) {
                    _viewModel.weight = value;
                  },
                ),
                ElevatedButton.icon(
                  onPressed: () => _viewModel.addFutureSituationAspect(context),
                  icon: const Icon(Icons.add),
                  label: Text(_viewModel.addFutureSituationAspectText),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(_viewModel.examplesTitle),
          const SizedBox(
            height: 10,
          ),
          Examples(controller: _controller, viewModel: _viewModel),
        ],
      ),
    );
  }
}
