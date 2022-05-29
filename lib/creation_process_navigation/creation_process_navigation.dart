import 'package:flutter/material.dart';
import 'package:pd_app/creation_process_navigation/creation_process_navigation_view_model.dart';
import 'package:provider/provider.dart';

class CreationProcessNavigation<ViewModelClass extends CreationProcessNavigationViewModel> extends StatelessWidget {
  const CreationProcessNavigation({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        NavigationBar<ViewModelClass>(),
        Expanded(child: widget),
        NavigationBar<ViewModelClass>(),
      ],
    ));
  }
}

class NavigationBar<ViewModelClass extends CreationProcessNavigationViewModel> extends StatelessWidget {
  const NavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ViewModelClass _viewModel = context.watch();

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
                        onPressed: () => _viewModel.onBackButtonPressed(context),
                        child: Text(_viewModel.backButtonText),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      ElevatedButton(
                          onPressed: () => _viewModel.onNextButtonPressed(context),
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
