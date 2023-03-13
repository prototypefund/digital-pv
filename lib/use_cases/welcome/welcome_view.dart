import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pd_app/general/themes/themes.dart';
import 'package:pd_app/use_cases/welcome/welcome_view_model.dart';
import 'package:pd_app/use_cases/welcome/welcome_view_page_controller.dart';
import 'package:pd_app/use_cases/welcome/welcome_view_page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
    WelcomeViewPageController _controller = _viewModel.pageController;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: _viewModel.pageController,
                onPageChanged: (value) => setState(() => _controller.currentPage = value),
                itemCount: _viewModel.pageController.numberOfPages,
                itemBuilder: (context, pageIndex) {
                  final viewModel = _controller.modelAtIndex(pageIndex);
                  return Padding(
                    padding: EdgeInsets.fromLTRB(10.0.w, 4.0.h, 10.0.w, 2.0.h),
                    child: Column(
                      children: [
                        Image.asset(viewModel.image, height: 27.0.h),
                        Flexible(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(8.0.w, 4.0.h, 4.0.w, 2.0.h),
                              child: MarkdownBody(
                                data: viewModel.markdown,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [if (_controller.isLastPage) _lastPage(_viewModel, context) else _firstPages(context)],
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
      padding: EdgeInsets.fromLTRB(10.0.w, 2.0.h, 10.0.w, 2.0.h),
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
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            ),
            child: Text(_viewModel.nextButtonText),
          ),
        ],
      ),
    );
  }

  Padding _lastPage(WelcomeViewModel viewModel, BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0.w, 2.h, 10.0.w, 2.0.h),
      child: ElevatedButton(
        onPressed: () => viewModel.onCallToActionPressed(context),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        ),
        child: Text(viewModel.callToActionText),
      ),
    );
  }
}
