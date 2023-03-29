import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pd_app/general/background.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/themes/sizes.dart';
import 'package:pd_app/general/themes/thresholds.dart';
import 'package:pd_app/general/view_components/directive_visualization/directive_visualization.dart';
import 'package:pd_app/general/view_components/navigation_drawer/drawer.dart';
import 'package:pd_app/general/view_components/navigation_drawer/drawer_view_model.dart';
import 'package:pd_app/general/view_components/responsive_addon_content/responsive_addon_content.dart';
import 'package:provider/provider.dart';

class CreationProcessNavigation<ViewModelType extends CreationProcessNavigationViewModel> extends StatelessWidget {
  const CreationProcessNavigation({super.key, required this.widget, this.floatingAddonWidget});

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
    final ViewModelType viewModel = context.watch<ViewModelType>();
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double paddingTop = MediaQuery.of(context).padding.top;
    final useExtendedWidthForContent = deviceWidth >= responsiveAddonThreshold;
    return Scaffold(
      drawer: ChangeNotifierProvider(create: (_) => DrawerViewModel(), child: const DPVDrawer()),
      bottomNavigationBar: Card(
          margin: EdgeInsets.zero,
          child: Padding(padding: Paddings.bottomNavigationBarPadding, child: NavigationBarButtons<ViewModelType>())),
      body: ColoredBox(
        color: Theme.of(context).colorScheme.background,
        child: Stack(
          children: [
            CustomScrollView(
              controller: viewModel.scrollController,
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  // disables back button if popping is possible
                  backgroundColor: Theme.of(context).colorScheme.background,
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
                              viewModel.showAspectVisualizationInNavbarIfNotShowingFloatingVisualization,
                          child: DirectiveVisualization.widgetWithViewModel(
                              showLabels: false, showTreatmentGoal: viewModel.showTreatmentGoalInVisualization)),
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
                        child: viewModel.showFloatingAspectVisualizationIfSpaceAvailable
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
            if (deviceWidth > responsiveAddonThreshold && viewModel.showFloatingAspectVisualizationIfSpaceAvailable)
              Positioned(
                  left: deviceWidth * 0.6,
                  right: 0,
                  top: 0 + paddingTop + Sizes.toolbarHeight,
                  bottom: 0,
                  child: Padding(
                      padding: Paddings.floatingAspectVisualizationPadding,
                      child: DirectiveVisualization.widgetWithViewModel(
                          showLabels: true, showTreatmentGoal: viewModel.showTreatmentGoalInVisualization)))
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
    super.key,
    required this.child,
    required this.maxWidth,
  });

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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ViewModelType viewModel = context.watch();

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
                    visible: viewModel.backButtonVisible,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.arrow_back_ios_sharp,
                        size: iconSize,
                      ),
                      onPressed: viewModel.backButtonEnabled ? () => viewModel.onBackButtonPressed(context) : null,
                      label: Text(viewModel.backButtonText),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Visibility(
                    visible: viewModel.nextButtonVisible,
                    child: viewModel.nextButtonShowArrow
                        ? ElevatedButton.icon(
                            icon: const Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: iconSize,
                            ),
                            onPressed:
                                viewModel.nextButtonEnabled ? () => viewModel.onNextButtonPressed(context) : null,
                            label: Text(
                              viewModel.nextButtonText,
                            ))
                        : ElevatedButton(
                            onPressed:
                                viewModel.nextButtonEnabled ? () => viewModel.onNextButtonPressed(context) : null,
                            child: Text(
                              viewModel.nextButtonText,
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
