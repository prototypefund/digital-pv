import 'dart:math' as math;

import 'package:arrow_path/arrow_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/view_components/aspect_visualization/aspect_visualization_view_model.dart';
import 'package:pd_app/logging.dart';
import 'package:provider/provider.dart';

class AspectVisualization extends StatelessWidget {
  static Widget widgetWithViewModel({required bool showLabels}) => ChangeNotifierProvider(
      create: (_) => AspectVisualizationViewModel(showLabels: showLabels), child: AspectVisualization());

  @override
  Widget build(BuildContext context) {
    final AspectVisualizationViewModel _viewModel = context.watch();

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Stack(
            children: [
              Image.asset(_viewModel.evaluationImageBackground),
              if (_viewModel.showLabels)
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ArcText(
                          radius: (constraints.maxWidth / 2) * 0.88,
                          text: _viewModel.palliativeLabel,
                          textStyle: Theme.of(context).textTheme.labelSmall!,
                          startAngle: (-math.pi / 2) + 0.1,
                          startAngleAlignment: StartAngleAlignment.start,
                          placement: Placement.outside,
                          direction: Direction.clockwise);
                    },
                  ),
                ),
              if (_viewModel.showLabels)
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ArcText(
                          radius: (constraints.maxWidth / 2) * 0.88,
                          text: _viewModel.curativeLabel,
                          textStyle: Theme.of(context).textTheme.labelSmall!,
                          startAngle: (math.pi / 2) - 0.1,
                          startAngleAlignment: StartAngleAlignment.end,
                          placement: Placement.outside,
                          direction: Direction.clockwise);
                    },
                  ),
                ),
              if (_viewModel.showLabels)
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ArcText(
                          radius: (constraints.maxWidth / 2) * 0.88,
                          text: _viewModel.negativeLabel,
                          textStyle: Theme.of(context).textTheme.labelSmall!,
                          startAngle: (math.pi / 2) + 0.1,
                          startAngleAlignment: StartAngleAlignment.start,
                          placement: Placement.outside,
                          direction: Direction.clockwise);
                    },
                  ),
                ),
              if (_viewModel.showLabels)
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ArcText(
                          radius: (constraints.maxWidth / 2) * 0.88,
                          text: _viewModel.positiveLabel,
                          textStyle: Theme.of(context).textTheme.labelSmall!,
                          startAngle: (-math.pi / 2) - 0.1,
                          startAngleAlignment: StartAngleAlignment.end,
                          placement: Placement.outside,
                          direction: Direction.clockwise);
                    },
                  ),
                ),
              if (_viewModel.showLabels)
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ArcText(
                          radius: (constraints.maxWidth / 2) * 0.86,
                          text: _viewModel.treatmentGoalLabel,
                          textStyle: Theme.of(context).textTheme.labelMedium!,
                          startAngle: 0,
                          startAngleAlignment: StartAngleAlignment.center,
                          placement: Placement.outside,
                          direction: Direction.clockwise);
                    },
                  ),
                ),
              if (_viewModel.showLabels)
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ArcText(
                          radius: (constraints.maxWidth / 2) * 0.86,
                          text: _viewModel.qualityOfLifeLabel,
                          textStyle: Theme.of(context).textTheme.labelMedium!,
                          startAngle: math.pi,
                          startAngleAlignment: StartAngleAlignment.center,
                          placement: Placement.outside,
                          direction: Direction.counterClockwise);
                    },
                  ),
                ),
              Positioned.fill(
                child: Transform.rotate(
                  angle: _viewModel.arrowRotation,
                  child: CustomPaint(
                    painter: ArrowPainter(color: DefaultThemeColors.purple), // TODO change to theme extension
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ArrowPainter extends CustomPainter with Logging {
  ArrowPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 3.0;

    Path path = Path();
    path.moveTo(size.width * 0.12, size.height / 2);
    path.relativeLineTo(size.width * 0.76, 0);
    path = ArrowPath.make(path: path);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
