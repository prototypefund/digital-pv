import 'package:flutter/material.dart';
import 'package:pd_app/general/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:provider/provider.dart';

class CreationProcessNavigation extends StatelessWidget {
  const CreationProcessNavigation({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Widget widget;

  static const double maximumContentWidth = 1200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const NavigationBar(),
        Expanded(child: Container(constraints: const BoxConstraints(maxWidth: maximumContentWidth), child: widget)),
        const NavigationBar(),
      ],
    ));
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CreationProcessNavigationViewModel _viewModel = context.watch();

    return Material(
      elevation: 15,
      child: Container(
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: _viewModel.backButtonEnabled ? () => _viewModel.onBackButtonPressed(context) : null,
                        child: Text(_viewModel.backButtonText),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      ElevatedButton(
                          onPressed:
                              _viewModel.nextButtonEnabled ? () => _viewModel.onNextButtonPressed(context) : null,
                          child: Text(
                            _viewModel.nextButtonText,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
