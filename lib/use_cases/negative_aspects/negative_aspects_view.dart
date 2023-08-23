import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation.dart';
import 'package:pd_app/general/markdown/markdown_body.dart';
import 'package:pd_app/general/model/aspect.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/view_components/circle_painer.dart';
import 'package:pd_app/general/view_components/custom_track_shape.dart';
import 'package:pd_app/general/view_components/directive_visualization/border_slider_thumb_shape.dart';
import 'package:pd_app/general/view_components/view_helper.dart';
import 'package:pd_app/general/view_components/webview_container.dart';
import 'package:pd_app/use_cases/negative_aspects/negative_aspects_view_model.dart';
import 'package:pd_app/use_cases/positive_aspects/positive_aspects_view_model.dart';
import 'package:provider/provider.dart';
import 'package:webviewx/webviewx.dart';

class NegativeAspects extends StatelessWidget {
  const NegativeAspects({super.key});

  static Widget page({required Aspect? focusAspect}) {
    return ChangeNotifierProvider(
        create: (_) => NegativeAspectsViewModel(focusAspect: focusAspect), child: const NegativeAspects());
  }

  @override
  Widget build(BuildContext context) {
    final NegativeAspectsViewModel viewModel = context.watch<NegativeAspectsViewModel>();

    return CreationProcessNavigation<NegativeAspectsViewModel>(
      widget: Column(
        children: [
          buildCenterText(
            viewModel.subtitle,
            context,
          ),
          const SizedBox(height: 80),
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  left: 55.0,
                  top: 20,
                  child: CustomPaint(
                    painter: CirclePainter(strokeColor: DefaultThemeColors.brownGrey),
                  )),
              buildText(
                viewModel.title,
                context,
              ),
            ],
          ),
          buildText(viewModel.subtopic, context),
          const SizedBox(height: 120),
          buildCenterText(
            viewModel.visualizationTitle,
            context,
          ),
          Stack(alignment: Alignment.topRight, children: [
            const WebViewAware(
              child: WebViewContainer(data: """
    // Read data
    var data = [
    { value: 40, key: "Unabhängigkeit", selected: false  , show_label: false , positive: true},
    { value: 55, key: "Gesundheit", selected: false   , show_label: false, positive: true},
    { value: 33, key: "Finanzen", selected: false  , show_label: false, positive: true},
    { value: 20, key: "Freunde", selected: false   , show_label: false, positive: true},
    { value: 14, key: "Natur", selected: false  , show_label: false, positive: true},
    { value: 12, key: "Mein Hund",  selected: false   , show_label: false, positive: true},
    { value: 10, key: "Arbeit", selected: false , show_label: false, positive: true},
    { value: 83, key: "Genesung", selected: true , show_label: true, positive: true},
    { value: 83, key: "Genesung", selected: false , show_label: false, positive: false},
    { value: 13, key: "Genesung", selected: false , show_label: false, positive: false},
    { value: 23, key: "Genesung", selected: true , show_label: true, positive: false},
    { value: 55, key: "Gesundheit", selected: false   , show_label: false, positive: false},
]; 
"""),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildText(viewModel.visualizationNegativeTitle, context, textColor: DefaultThemeColors.brownGrey),
            ),
          ]),
          const SizedBox(
            height: 120,
          ),
          if (viewModel.navigationStep == NavigationStep.description) ...description(context, viewModel),
          if (viewModel.navigationStep == NavigationStep.select) ...selectItem(context, viewModel),
          if (viewModel.navigationStep == NavigationStep.edit) ...editItem(context, viewModel),
          if (viewModel.navigationStep == NavigationStep.complete) ...complete(context, viewModel),
        ],
      ),
    );
  }

  List<Widget> editItem(BuildContext context, NegativeAspectsViewModel viewModel) {
    return [
      Row(
        children: [
          card(
              showCheckboxBelow: false,
              markdown: viewModel.ownAspect,
              assetPath: "assets/images/create.svg",
              more: viewModel.more),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MarkdownBody(content: viewModel.describeNegativeAspectTitle),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: viewModel.aspectNameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 25),
                        labelText: viewModel.aspectNameLabel,
                        hintText: viewModel.aspectNameHint,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide:
                              const BorderSide(width: 2, color: DefaultThemeColors.magenta), // change color here
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              width: 2, color: DefaultThemeColors.veryDarkMagenta), // change color here
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: viewModel.detailDescriptionController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 25),
                        labelText: viewModel.aspectDetailLabel,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide:
                              const BorderSide(width: 2, color: DefaultThemeColors.magenta), // change color here
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              width: 2, color: DefaultThemeColors.veryDarkMagenta), // change color here
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: DefaultThemeColors.magenta,
                            inactiveTrackColor: DefaultThemeColors.lightMagenta.withOpacity(0.5),
                            trackShape: CustomTrackShape(),
                            trackHeight: 40.0,
                            thumbColor: Colors.white,
                            thumbShape: BorderSliderThumbShape(thumbRadius: 30, borderThickness: 6),
                            overlayColor: DefaultThemeColors.magenta.withAlpha(32),
                            overlayShape: const RoundSliderOverlayShape(overlayRadius: 40.0),
                            tickMarkShape: const RoundSliderTickMarkShape(),
                            activeTickMarkColor: DefaultThemeColors.darkMagenta,
                            inactiveTickMarkColor: Colors.red[100],
                            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                            valueIndicatorColor: DefaultThemeColors.veryDarkMagenta.withOpacity(0.8),
                            valueIndicatorTextStyle: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          child: Expanded(
                            child: Slider(
                              value: viewModel.currentSliderValue,
                              min: 0,
                              max: 100,
                              // divisions: 5,
                              label: viewModel.currentSliderValue.round().toString(),
                              onChanged: (double value) {
                                viewModel.currentSliderValue = value;
                              },
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(viewModel.lowWeightLabel),
                          Text(viewModel.middleWeightLabel),
                          Text(viewModel.highWeightLabel),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    ];
  }

  List<Widget> description(BuildContext context, NegativeAspectsViewModel viewModel) {
    return [
      const SizedBox(height: 90),
      buildRowWithExpandedText(context, viewModel.descriptionOne, viewModel.explanationOne,
          color: DefaultThemeColors.brownGrey),
      const SizedBox(height: 60),
      buildRowWithExpandedText(context, viewModel.descriptionTwo, viewModel.explanationTwo,
          color: DefaultThemeColors.brownGrey),
    ];
  }

  List<Widget> complete(BuildContext context, NegativeAspectsViewModel viewModel) {
    return [
      const SizedBox(height: 90),
      buildRowWithExpandedText(context, viewModel.completeDescriptionOne, viewModel.completeExplanationOne,
          color: DefaultThemeColors.brownGrey),
      const SizedBox(height: 60),
      buildRowWithExpandedText(context, viewModel.completeDescriptionTwo, viewModel.completeExplanationTwo,
          color: DefaultThemeColors.brownGrey),
    ];
  }

  List<Widget> get items {
    return [
      ...Iterable<int>.generate(25).map(
        (i) => card(
          more: "Mehr",
          markdown: """
#### Beispiel 
Positiver Aspekt des aktuellen Lebens
### Unabhängigkeit
""",
          assetPath: "assets/images/create.svg",
        ),
      )
    ];
  }

  PageController pageController(NegativeAspectsViewModel viewModel, double viewPortFraction) {
    return viewModel.pageController =
        PageController(viewportFraction: viewPortFraction, initialPage: items.length > 4 ? 1 : 0);
  }

  List<Widget> selectItem(BuildContext context, NegativeAspectsViewModel viewModel) {
    return [
      buildCenterText(viewModel.selectAspectTitle, context),
      Row(children: [
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
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25, top: 100, bottom: 0), child: items[index]);
                },
              ),
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
      ]),
    ];
  }
}
