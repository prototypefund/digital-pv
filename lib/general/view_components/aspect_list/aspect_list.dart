import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as md;
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/view_components/aspect_list/aspect_list_view_model.dart';
import 'package:pd_app/general/view_components/aspect_widget/aspect_widget.dart';
import 'package:pd_app/general/view_components/view_helper.dart';
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
        buildCenterText(viewModel.selectItemTitle, context),
        Row(
          children: [
            MouseRegion(
              onEnter: (_) {
                viewModel.trianglePainter.isHovering.value = true;
              },
              onExit: (_) {
                viewModel.trianglePainter.isHovering.value = false;
              },
              child: ValueListenableBuilder<bool>(
                valueListenable: viewModel.trianglePainter.isHovering,
                builder: (context, isHovering, child) {
                  return RawMaterialButton(
                    hoverElevation: 0,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    elevation: 0,
                    focusElevation: 0,
                    hoverColor: Colors.transparent,
                    onPressed: () => viewModel.pageController
                        .previousPage(duration: const Duration(milliseconds: 200), curve: Curves.easeIn),
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CustomPaint(painter: viewModel.trianglePainter),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                return ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 660),
                  child: PageView.builder(
                      controller: pageController(viewModel, (310) / constraints.maxWidth),
                      scrollDirection: Axis.horizontal,
                      itemCount: viewModel.aspects.length,
                      itemBuilder: (context, index) {
                        final aspect = viewModel.aspects[index];
                        return Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25, top: 100, bottom: 0),
                            child: card(
                              onChanged: (value) {
                                // example.selected = value ?? false;
                              },
                              // checked: example.selected,
                              edgeInsets: const EdgeInsets.all(12),
                              styleSheet: md.MarkdownStyleSheet(
                                  p: const TextStyle(fontSize: 14),
                                  textAlign: WrapAlignment.center,
                                  h1Align: WrapAlignment.center,
                                  h2Align: WrapAlignment.center,
                                  h3Align: WrapAlignment.center,
                                  h4Align: WrapAlignment.center,
                                  h5Align: WrapAlignment.center,
                                  h6Align: WrapAlignment.center),
                              more: "Mehr",
                              markdown: """
#### ${viewModel.cardTitle}
${viewModel.cardSubtitle(index)}
### ${aspect.name}
#### ${aspect.description ?? ""}
""",
                              assetPath: "assets/images/create.svg",
                            ));
                      }),
                );
              }),
            ),
            MouseRegion(
              onEnter: (_) {
                viewModel.trianglePainterRight.isHovering.value = true;
              },
              onExit: (_) {
                viewModel.trianglePainterRight.isHovering.value = false;
              },
              child: ValueListenableBuilder<bool>(
                  valueListenable: viewModel.trianglePainterRight.isHovering,
                  builder: (context, isHovering, child) {
                    return RawMaterialButton(
                      hoverElevation: 0,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      elevation: 0,
                      focusElevation: 0,
                      hoverColor: Colors.transparent,
                      onPressed: () => viewModel.pageController
                          .nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeIn),
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CustomPaint(painter: viewModel.trianglePainterRight),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildListItem(BuildContext context, int index, Animation<double> animation) {
    final AspectListViewModel<AspectType> viewModel = context.watch();
    final AspectType aspect = viewModel.aspects[index];
    return SizedBox(
      height: viewModel.listItemHeight,
      child: Padding(
        key: Key(aspect.name),
        padding: Paddings.listElementPadding,
        child:
            _buildListItem(animation: animation, aspect: aspect, viewModel: viewModel, interactive: true, index: index),
      ),
    );
  }

  PageController pageController(AspectListViewModel viewModel, double viewPortFraction) {
    return viewModel.pageController =
        PageController(viewportFraction: viewPortFraction, initialPage: viewModel.aspects.isNotEmpty ? 1 : 0);
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
