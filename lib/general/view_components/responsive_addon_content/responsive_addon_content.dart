import 'package:flutter/material.dart';

/// if there is only little width, only the child is shown.
/// If there is enough available width, a second column is shown, which displays the additional content
class ResponsiveAddonContent extends StatelessWidget {
  const ResponsiveAddonContent(
      {super.key, required this.widthThreshold, required this.extendedContent, required this.child});

  final double widthThreshold;
  final Widget child;
  final Widget extendedContent;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    if (deviceWidth <= widthThreshold) {
      return child;
    } else {
      return Row(
        children: [
          Expanded(flex: 6, child: child),
          Expanded(
            flex: 4,
            child: extendedContent,
          )
        ],
      );
    }
  }
}
