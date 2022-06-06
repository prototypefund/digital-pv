import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pd_app/general/themes/images.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  static const int backgroundPatternRepetitions = 10;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Column(
            children: _buildBackgroundChildren(context, repetitions: backgroundPatternRepetitions),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildBackgroundChildren(BuildContext context, {required int repetitions}) {
    return List.generate(repetitions, (index) => index)
        .expand(
            (index) => _getBaseBackgroundPattern(context, flipHorizontal: index % 4 == 1, flipVertical: index % 4 == 3))
        .toList();
  }

  List<Widget> _getBaseBackgroundPattern(BuildContext context,
      {required bool flipHorizontal, required bool flipVertical}) {
    return [
      const SizedBox(
        height: 200,
      ),
      Transform.scale(
        scaleX: flipHorizontal ? -1 : 1,
        scaleY: flipVertical ? -1 : 1,
        child: SvgPicture.asset(
          Images.backgroundDecorationPath(),
          width: MediaQuery.of(context).size.width,
        ),
      ),
      const SizedBox(
        height: 100,
      ),
    ];
  }
}
