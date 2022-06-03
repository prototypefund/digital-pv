import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:provider/provider.dart';

class CreationProcessNavigation<ViewModelType extends CreationProcessNavigationViewModel> extends StatelessWidget {
  const CreationProcessNavigation({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Widget widget;

  static const double maximumContentWidth = 1200;
  static const double sliverBarContentPadding = 8.0;
  static const double contentAreaPadding = 32.0;
  static const double sliverAppBarExpandedHeight = 160.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
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
              child: ConstrainedSliverWidth(
                maxWidth: maximumContentWidth,
                child: Padding(
                  padding: const EdgeInsets.all(contentAreaPadding),
                  child: widget,
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
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.arrow_back_ios_sharp,
                      size: iconSize,
                    ),
                    onPressed: _viewModel.backButtonEnabled ? () => _viewModel.onBackButtonPressed(context) : null,
                    label: Text(_viewModel.backButtonText),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  ElevatedButton.icon(
                      icon: const Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: iconSize,
                      ),
                      onPressed: _viewModel.nextButtonEnabled ? () => _viewModel.onNextButtonPressed(context) : null,
                      label: Text(
                        _viewModel.nextButtonText,
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
