import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/themes/constraints.dart';
import 'package:pd_app/general/themes/paddings.dart';
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
          Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: DefaultThemeColors.darkGreyTransparent,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(28.0),
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
              )),
          Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: DefaultThemeColors.darkGreyTransparent,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
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
          ),
          const SizedBox(
            height: 40,
          ),
          Text(_viewModel.examplesTitle),
          const SizedBox(
            height: 10,
          ),
          _Examples(controller: _controller, viewModel: _viewModel),
        ],
      ),
    );
  }
}

class _Examples extends StatelessWidget {
  const _Examples({
    Key? key,
    required TabController controller,
    required FutureSituationsViewModel viewModel,
  })  : _controller = controller,
        _viewModel = viewModel,
        super(key: key);

  final TabController _controller;
  final FutureSituationsViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Align(
        alignment: Alignment.topLeft,
        child: TabBar(
            labelColor: DefaultThemeColors.white,
            unselectedLabelColor: DefaultThemeColors.darkGrey,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: DefaultThemeColors.purple),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            indicatorWeight: 0,
            indicatorColor: Colors.transparent,
            indicator: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                color: DefaultThemeColors.purple),
            controller: _controller,
            tabs: _viewModel.examples
                .map(
                  (e) => Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          border: Border.all(width: 1, color: DefaultThemeColors.darkGreyTransparent)),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text(e.title),
                      ),
                    ),
                  ),
                )
                .toList()),
      ),
      Transform.translate(
        offset: const Offset(0, -1),
        child: _Border(
          child: SizedBox(
            height: 500,
            child: TabBarView(
              controller: _controller,
              children: _viewModel.examples.asMap().entries.map((entry) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  child: Wrap(
                    children: entry.value.children
                        .asMap()
                        .entries
                        .map((child) => _Entry(
                              item: child.value,
                              onPressed: () => _viewModel.chooseExample(child.value.title),
                            ))
                        .toList(),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    ]);
  }
}

class _Entry extends StatelessWidget {
  const _Entry({
    Key? key,
    required this.item,
    required this.onPressed,
  }) : super(key: key);

  final Item item;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.exampleButtonPadding,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(
          width: 1.0,
          color: DefaultThemeColors.darkGreyTransparent,
          style: BorderStyle.solid,
        )),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent, cardColor: Colors.transparent),
            child: item.description == null
                ? Wrap(
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  )
                : ExpandableNotifier(
                    child: Wrap(children: [
                      ExpandableTheme(
                        // Duration.zero resulted in issues
                        data: const ExpandableThemeData(animationDuration: Duration(milliseconds: 1)),
                        child: Expandable(
                          collapsed: ExpandableWrapper(
                            icon: const Icon(
                              Icons.info,
                              color: DefaultThemeColors.purple,
                            ),
                            child: Text(
                              item.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          expanded: ExpandableWrapper(
                            icon: const Icon(
                              Icons.close,
                              color: DefaultThemeColors.purple,
                            ),
                            child: Text(
                              item.titleWithDescription,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
          ),
        ),
      ),
    );
  }
}

class _Border extends StatelessWidget {
  final Widget child;
  const _Border({Key? key, required this.child}) : super(key: key);

  static const _borderColor = DefaultThemeColors.darkGreyTransparent;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: const BoxDecoration(
          color: Color.fromARGB(0, 240, 242, 245),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10), topRight: Radius.circular(10)),
          border: Border(
            left: BorderSide(width: 1, color: _borderColor),
            right: BorderSide(width: 1, color: _borderColor),
            top: BorderSide(width: 1, color: _borderColor),
            bottom: BorderSide(width: 1, color: _borderColor),
          ),
        ),
        child: child);
  }
}

class ExpandableWrapper extends StatelessWidget {
  final Widget child;
  final Icon icon;
  const ExpandableWrapper({Key? key, required this.child, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Wrap(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [child],
            ),
          ),
          ExpandableButton(child: icon),
        ],
      ),
    );
  }
}
