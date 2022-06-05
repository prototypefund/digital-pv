import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:pd_app/general/themes/images.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: Svg(
              Images.backgroundDecorationPath,
            ),
            repeat: ImageRepeat.repeatY,
            alignment: Alignment.topCenter),
      ),
      child: child,
    );
  }
}
