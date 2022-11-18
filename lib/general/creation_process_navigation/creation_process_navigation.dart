import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pd_app/general/background.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:provider/provider.dart';

class CreationProcessNavigation<ViewModelType extends CreationProcessNavigationViewModel> extends StatelessWidget {
  const CreationProcessNavigation({
    super.key,
    required this.widget,
  });

  final Widget widget;

  static const double maximumContentWidth = 1200;
  static const double sliverBarContentPadding = 8.0;
  static const double contentAreaPadding = 32.0;
  static const double sliverAppBarExpandedHeight = 160.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: Theme.of(context).backgroundColor,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              // disables back button if popping is possible
              backgroundColor: Theme.of(context).primaryColor,
              pinned: true,
              snap: false,
              floating: true,
              expandedHeight: sliverAppBarExpandedHeight,
              title: NavigationBarButtons<ViewModelType>(),
              flexibleSpace: const FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.all(sliverBarContentPadding),
                  child: FlutterLogo(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: BackgroundContainer(
                child: ConstrainedSliverWidth(
                  maxWidth: maximumContentWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(contentAreaPadding),
                    child: widget,
                  ),
                ),
              ),
            )
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
                    child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: iconSize,
                        ),
                        onPressed: viewModel.nextButtonEnabled ? () => viewModel.onNextButtonPressed(context) : null,
                        label: Text(
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
