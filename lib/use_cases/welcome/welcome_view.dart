import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pd_app/general/themes/themes.dart';
import 'package:pd_app/use_cases/welcome/welcome_view_model.dart';
import 'package:pd_app/use_cases/welcome/welcome_view_page_controller.dart';
import 'package:pd_app/use_cases/welcome/welcome_view_page_indicator.dart';
import 'package:provider/provider.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  static Widget page() {
    return ChangeNotifierProvider(
      create: (context) => WelcomeViewModel(),
      child: const WelcomeView(),
    );
  }

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  late WelcomeViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch();
    final WelcomeViewPageController controller = _viewModel.pageController;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: _viewModel.pageController,
                onPageChanged: (value) => setState(() => controller.currentPage = value),
                itemCount: _viewModel.pageController.numberOfPages,
                itemBuilder: (context, pageIndex) {
                  final viewModel = controller.modelAtIndex(pageIndex);
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: Column(
                        children: [
                          Flexible(child: Image.asset(viewModel.image)),
                          Flexible(
                            child: Center(
                              child: MarkdownBody(
                                data: viewModel.markdown,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [if (controller.isLastPage) _lastPage(_viewModel, context) else _firstPages(context)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _firstPages(BuildContext context) {
    _viewModel = context.watch();
    final controller = _viewModel.pageController;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              controller.jumpToLastPage();
            },
            child: Text(
              _viewModel.skipButtonText,
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.numberOfPages,
                (int index) =>
                    WelcomeViewPageIndicator(currentPage: controller.currentPage, context: context, index: index),
              )),
          ElevatedButton(
            onPressed: () {
              controller.nextPage(
                duration: defaultDuration,
                curve: Curves.easeIn,
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            ),
            child: Text(_viewModel.nextButtonText),
          ),
        ],
      ),
    );
  }

  Padding _lastPage(WelcomeViewModel viewModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 2, 10.0, 2.0),
      child: ElevatedButton(
        onPressed: () => viewModel.onCallToActionPressed(context),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        ),
        child: Text(viewModel.callToActionText),
      ),
    );
  }
}
