import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WelcomeViewPageIndicator extends StatelessWidget {
  const WelcomeViewPageIndicator({
    Key? key,
    required this.currentPage,
    required this.context,
    required this.index,
  }) : super(key: key);

  final int currentPage;
  final BuildContext context;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(90.w),
        ),
        color: Theme.of(context).primaryColor,
      ),
      margin: EdgeInsets.only(right: 0.4.w),
      height: Device.aspectRatio > 1.7 ? 3.h : 1.h,
      curve: Curves.easeIn,
      width: currentPage == index ? (Device.aspectRatio > 1.7 ? 3.w : 4.w) : (Device.aspectRatio > 1.7 ? 1.8.w : 2.w),
    );
  }
}
