import 'package:flutter/material.dart';
import 'package:pd_app/welcome/welcome_view_model.dart';
import 'package:provider/provider.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  static Widget page() {
    return ChangeNotifierProvider(
      create: (context) => WelcomeViewModel(),
      child: const WelcomeView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final WelcomeViewModel _viewModel = context.watch();
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => _viewModel.onCallToActionPressed(context),
          child: Text(_viewModel.callToActionText),
        ),
      ),
    );
  }
}
