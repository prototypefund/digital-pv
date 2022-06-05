import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/images.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(Images.backgroundDecorationPath()),
            repeat: ImageRepeat.repeatY,
            alignment: Alignment.topCenter),
      ),
      child: child,
    );
  }
}
