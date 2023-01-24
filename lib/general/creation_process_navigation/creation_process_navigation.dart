import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pd_app/general/background.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/themes/sizes.dart';
import 'package:pd_app/general/themes/thresholds.dart';
import 'package:pd_app/general/view_components/aspect_visualization/aspect_visualization.dart';
import 'package:pd_app/general/view_components/navigation_drawer/drawer.dart';
import 'package:pd_app/general/view_components/responsive_addon_content/responsive_addon_content.dart';
import 'package:provider/provider.dart';

class CreationProcessNavigation<ViewModelType extends CreationProcessNavigationViewModel> extends StatelessWidget {
  const CreationProcessNavigation({Key? key, required this.widget, this.floatingAddonWidget}) : super(key: key);

  final Widget widget;

  /// if enough space is available, a floating widget will be displayed next to the scrolling content
  final Widget? floatingAddonWidget;

  static const double maximumContentWidth = 1200;
  static const double responsiveAddonThreshold = Thresholds.responsiveAddonContent;
  static const double sliverBarContentPadding = 8.0;
  static const double contentAreaPadding = 32.0;
  static const double sliverAppBarExpandedHeight = 160.0;

  @override
  Widget build(BuildContext context) {
    final ViewModelType _viewModel = context.watch<ViewModelType>();
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double paddingTop = MediaQuery.of(context).padding.top;
    final useExtendedWidthForContent = deviceWidth >= responsiveAddonThreshold;
    return Scaffold(
      drawer: const DPVDrawer(),
      bottomNavigationBar: Card(
          margin: EdgeInsets.zero,
          child: Padding(padding: EdgeInsets.all(8), child: NavigationBarButtons<ViewModelType>())),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  // disables back button if popping is possible
                  backgroundColor: Theme.of(context).primaryColor,
                  leading: Builder(builder: (context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.menu,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    );
                  }),
                  pinned: true,
                  snap: false,
                  floating: true,
                  collapsedHeight: Sizes.toolbarHeight,
                  expandedHeight: useExtendedWidthForContent ? Sizes.toolbarHeight : sliverAppBarExpandedHeight,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.all(sliverBarContentPadding),
                      child: Visibility(
                          visible: deviceWidth < responsiveAddonThreshold &&
                              _viewModel.showAspectVisualizationInNavbarIfNotShowingFloatingVisualization,
                          child: AspectVisualization.widgetWithViewModel(
                              showLabels: false, showTreatmentGoal: _viewModel.showTreatmentGoalInVisualization)),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: BackgroundContainer(
                    child: ConstrainedSliverWidth(
                      maxWidth: maximumContentWidth,
                      child: Padding(
                        padding: const EdgeInsets.all(contentAreaPadding),
                        // will just make empty space for the stack to be drawn upon further up the widget tree
                        child: _viewModel.showFloatingAspectVisualizationIfSpaceAvailable
                            ? ResponsiveAddonContent(
                                extendedContent: const SizedBox.shrink(),
                                widthThreshold: responsiveAddonThreshold,
                                child: widget,
                              )
                            : widget,
                      ),
                    ),
                  ),
                )
              ],
            ),
            if (deviceWidth > responsiveAddonThreshold && _viewModel.showFloatingAspectVisualizationIfSpaceAvailable)
              Positioned(
                  left: deviceWidth * 0.6,
                  right: 0,
                  top: 0 + paddingTop + Sizes.toolbarHeight,
                  bottom: 0,
                  child: Padding(
                      padding: Paddings.floatingAspectVisualizationPadding,
                      child: AspectVisualization.widgetWithViewModel(
                          showLabels: true, showTreatmentGoal: _viewModel.showTreatmentGoalInVisualization)))
          ],
        ),
      ),
    );
  }
}

class ConstrainedSliverWidth extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ConstrainedSliverWidth({
    Key? key,
    required this.child,
    required this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = (size.width - maxWidth) / 2;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: max(padding, 0)),
      child: child,
    );
  }
}

class NavigationBarButtons<ViewModelType extends CreationProcessNavigationViewModel> extends StatelessWidget {
  const NavigationBarButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ViewModelType _viewModel = context.watch();

    const iconSize = 16.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Visibility(
                    visible: _viewModel.backButtonVisible,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.arrow_back_ios_sharp,
                        size: iconSize,
                      ),
                      onPressed: _viewModel.backButtonEnabled ? () => _viewModel.onBackButtonPressed(context) : null,
                      label: Text(_viewModel.backButtonText),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Visibility(
                    visible: _viewModel.nextButtonVisible,
                    child: _viewModel.nextButtonShowArrow
                        ? ElevatedButton.icon(
                            icon: const Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: iconSize,
                            ),
                            onPressed:
                                _viewModel.nextButtonEnabled ? () => _viewModel.onNextButtonPressed(context) : null,
                            label: Text(
                              _viewModel.nextButtonText,
                            ))
                        : ElevatedButton(
                            onPressed:
                                _viewModel.nextButtonEnabled ? () => _viewModel.onNextButtonPressed(context) : null,
                            child: Text(
                              _viewModel.nextButtonText,
                            )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
