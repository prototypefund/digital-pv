import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/themes/sizes.dart';
import 'package:pd_app/general/themes/thresholds.dart';
import 'package:pd_app/general/view_components/directive_visualization/directive_visualization.dart';
import 'package:pd_app/general/view_components/dpv_next_page_button.dart';
import 'package:pd_app/general/view_components/dpv_stepper.dart';
import 'package:pd_app/general/view_components/navigation_drawer/drawer.dart';
import 'package:pd_app/general/view_components/navigation_drawer/drawer_view_model.dart';
import 'package:pd_app/general/view_components/new_aspect/new_aspect_form_change_notification.dart';
import 'package:pd_app/general/view_components/responsive_addon_content/responsive_addon_content.dart';
import 'package:provider/provider.dart';

class CreationProcessNavigation<ViewModelType extends CreationProcessNavigationViewModel> extends StatelessWidget {
  const CreationProcessNavigation({super.key, required this.widget, this.floatingAddonWidget});

  final Widget widget;

  /// if enough space is available, a floating widget will be displayed next to the scrolling content
  final Widget? floatingAddonWidget;

  static const double maximumContentWidth = 1200;
  static const double responsiveAddonThreshold = Thresholds.responsiveAddonContent;
  static const double sliverBarContentPadding = 20;
  static const double contentAreaPadding = 32.0;
  static const double sliverAppBarExpandedHeight = 260.0;
  static const double stepperHeight = 75.0;

  @override
  Widget build(BuildContext context) {
    final ViewModelType viewModel = context.watch<ViewModelType>();
    final double deviceWidth = MediaQuery.of(context).size.width;
    final useExtendedWidthForContent = deviceWidth >= responsiveAddonThreshold;
    return NotificationListener<NewAspectFormChangeNotification>(
      onNotification: (notification) {
        viewModel.update();
        return true;
      },
      child: Scaffold(
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
                  if (viewModel.showAppBar)
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      // disables back button if popping is possible
                      backgroundColor: Theme.of(context).colorScheme.background,
                      title: SizedBox(
                        height: stepperHeight,
                        child: ChangeNotifierProvider(
                          create: (context) => viewModel,
                          child: DPVStepper(
                            physics: const ClampingScrollPhysics(),
                            currentStep: viewModel.currentStep(context),
                            type: StepperType.horizontal,
                            onStepContinue: () {
                              viewModel.onNextButtonPressed(context);
                            },
                            onStepTapped: (int index) {
                              viewModel.onStepContinue(context, index);
                            },
                            onStepCancel: () => viewModel.onBackButtonPressed(context),
                            steps: viewModel.navigationSteps
                                .mapIndexed(
                                  (index, e) => Step(
                                    content: const SizedBox(),
                                    state: viewModel.currentStep(context) == index + 1
                                        ? StepState.editing
                                        : viewModel.currentStep(context) > index + 1
                                            ? StepState.complete
                                            : StepState.disabled,
                                    title: Text(
                                      style: Theme.of(context).textTheme.bodySmall,
                                      e.stepName,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
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
                      flexibleSpace: Container(
                        margin: const EdgeInsets.only(top: 30.0),
                        child: FlexibleSpaceBar(
                          background: Padding(
                            padding: const EdgeInsets.all(50),
                            child: Visibility(
                                visible: deviceWidth < responsiveAddonThreshold &&
                                    viewModel.showAspectVisualizationInNavbarIfNotShowingFloatingVisualization,
                                child: DirectiveVisualization.widgetWithViewModel(
                                    simulateFutureAspects: viewModel.simulateFutureAspects,
                                    showLabels: false,
                                    showTreatmentGoal: viewModel.showTreatmentGoalInVisualization)),
                          ),
                        ),
                      ),
                    ),
                  SliverToBoxAdapter(
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
                ],
              ),
              // if (deviceWidth > responsiveAddonThreshold && viewModel.showFloatingAspectVisualizationIfSpaceAvailable)
              // Positioned(
              //     left: deviceWidth * 0.6,
              //     right: 0,
              //     top: 0 + paddingTop + Sizes.toolbarHeight,
              //     bottom: 0,
              //     child: Padding(
              //         padding: Paddings.floatingAspectVisualizationPadding,
              //         child: DirectiveVisualization.widgetWithViewModel(
              //             simulateFutureAspects: viewModel.simulateFutureAspects,
              //             showLabels: true,
              //             showTreatmentGoal: viewModel.showTreatmentGoalInVisualization)))
            ],
          ),
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Visibility(
                  visible: viewModel.backButtonVisible,
                  child: DPVNextPageButton(
                    title: viewModel.backButtonText,
                    canProceed: viewModel.backButtonEnabled,
                    onPressed: viewModel.backButtonEnabled ? () => viewModel.onBackButtonPressed(context) : () {},
                  ),

                  // ElevatedButton.icon(
                  //   icon: const Icon(
                  //     Icons.arrow_back_ios_sharp,
                  //     size: iconSize,
                  //   ),
                  //   onPressed: viewModel.backButtonEnabled ? () => viewModel.onBackButtonPressed(context) : null,
                  //   label: Text(viewModel.backButtonText),
                  // ),
                ),
                Visibility(
                  visible: viewModel.nextButtonVisible,
                  child: DPVNextPageButton(
                    alignment: Alignment.centerLeft,
                    title: viewModel.nextButtonText,
                    canProceed: viewModel.nextButtonEnabled,
                    onPressed: viewModel.nextButtonEnabled ? () => viewModel.onNextButtonPressed(context) : () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
