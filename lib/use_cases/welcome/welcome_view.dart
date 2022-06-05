import 'package:flutter/material.dart';
import 'package:pd_app/use_cases/welcome/welcome_view_model.dart';
import 'package:pd_app/use_cases/welcome/welcome_view_page_content_view_model.dart';
import 'package:pd_app/use_cases/welcome/welcome_view_page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final List<WelcomeViewPageContentViewModel> contents = [
  WelcomeViewPageContentViewModel(
      title: "Herzlich willkommen bei d-PV, Ihrer digitalen Patientenverfügung!",
      image: "assets/images/placeholder.png",
      description: "Erstellen Sie in drei Schritten eine rechtskonforme Patientenverfügung. "),
  WelcomeViewPageContentViewModel(
      title: "Medizinische Behandlung festlegen",
      image: "assets/images/placeholder.png",
      description: "Mit einer Patientenverfügung können Sie Ihre medizinische Behandlung für den"
          " Fall einer späteren Entscheidungs- bzw. Urteilsunfähigkeit im Voraus "
          "schriftlich festlegen. "),
  WelcomeViewPageContentViewModel(
      title: "Gesetzeskonform",
      image: "assets/images/placeholder.png",
      description: "Die dPV entspricht den gesetzlichen Vorgaben in Deutschland"
          " und in der Schweiz."),
  WelcomeViewPageContentViewModel(
      title: "Vertrauensperson",
      image: "assets/images/placeholder.png",
      description: "Statt eine vollständige Patientenverfügung anzulegen, können Sie prinzipiell "
          "sämtliche Entscheidungen der Vertretungsperson Ihres Vertrauens überlassen. In diesem Falle können"
          " Sie die Vertretungsperson hier direkt benennen."),
];

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

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
  final _controller = PageController();
  late WelcomeViewModel _viewModel;
  int _currentPage = 0;

  bool get _isLastPage {
    return _currentPage + 1 == contents.length;
  }

  int get _lastPageIndex {
    return contents.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: contents.length,
                itemBuilder: (context, pageIndex) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(10.0.w, 4.0.h, 10.0.w, 2.0.h),
                    child: Column(
                      children: [
                        Image.asset(contents[pageIndex].image, height: 27.0.h),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8.0.w, 4.0.h, 4.0.w, 2.0.h),
                            child: Text(
                              contents[pageIndex].title,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.0.h,
                        ),
                        Text(
                          contents[pageIndex].description,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
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
                children: [if (_isLastPage) _lastPage(_viewModel, context) else _firstPages(context)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _firstPages(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0.w, 2.0.h, 10.0.w, 2.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              _controller.jumpToPage(_lastPageIndex);
            },
            style: TextButton.styleFrom(
              elevation: 0,
              textStyle: Theme.of(context).textTheme.bodySmall,
            ),
            child: Text(
              _viewModel.skipButtonText,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (int index) => WelcomeViewPageIndicator(currentPage: _currentPage, context: context, index: index),
              )),
          ElevatedButton(
            onPressed: () {
              _controller.nextPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
              textStyle: Theme.of(context).textTheme.bodySmall,
            ),
            child: Text(_viewModel.nextButtonText),
          ),
        ],
      ),
    );
  }

  Padding _lastPage(WelcomeViewModel _viewModel, BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0.w, 2.h, 10.0.w, 2.0.h),
      child: ElevatedButton(
        onPressed: () => _viewModel.onCallToActionPressed(context),
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
            textStyle: Theme.of(context).textTheme.bodySmall),
        child: Text(_viewModel.callToActionText),
      ),
    );
  }
}
