import 'dart:math' as math;

import 'package:arrow_path/arrow_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';

// ignore: unused_import
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/themes/constraints.dart';
import 'package:pd_app/general/themes/extensions/aspect_visualization_style.dart';
import 'package:pd_app/general/view_components/aspect_visualization/aspect_visualization_view_model.dart';
import 'package:pd_app/logging.dart';
import 'package:provider/provider.dart';

class AspectVisualization extends StatelessWidget with Logging {
  const AspectVisualization({super.key, this.onDragAndRotate});

  /// is notified of drag events and their rotation; can be used to change treatment goal or other aspects of the directive using gestures
  /// top half has negative values
  /// bottom half has positive values
  /// left half has absolute values between PI/2 and PI
  /// right half has absolute values between 0 and PI/2
  final ValueChanged<double>? onDragAndRotate;

  static Widget widgetWithViewModel(
          {required bool showLabels, required bool showTreatmentGoal, ValueChanged<double>? onDragAndRotate}) =>
      ChangeNotifierProvider(
          create: (_) => AspectVisualizationViewModel(showLabels: showLabels, showTreatmentGoal: showTreatmentGoal),
          child: AspectVisualization(
            onDragAndRotate: onDragAndRotate,
          ));

  @override
  Widget build(BuildContext context) {
    final AspectVisualizationViewModel _viewModel = context.watch();

    final sectionLabelStyle = Theme.of(context).extension<AspectVisualizationStyle>()!.sectionLabelStyle!;
    final tendencyLabelStyle = Theme.of(context).extension<AspectVisualizationStyle>()!.tendencyLabelStyle!;
    final aspectEvaluationArrowColor =
        Theme.of(context).extension<AspectVisualizationStyle>()!.aspectEvaluationArrowColor ?? Colors.black;
    final aspectEvaluationArrowStrokeWidth =
        Theme.of(context).extension<AspectVisualizationStyle>()!.aspectEvaluationArrowStrokeWidth ?? 4;
    final treatmentGoalArrowColor =
        Theme.of(context).extension<AspectVisualizationStyle>()!.treatmentGoalArrowColor ?? Colors.black;
    final treatmentGoalArrowStrokeWidth =
        Theme.of(context).extension<AspectVisualizationStyle>()!.treatmentGoalArrowStrokeWidth ?? 9;
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
                          textStyle: tendencyLabelStyle,
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
                          textStyle: tendencyLabelStyle,
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
                          textStyle: tendencyLabelStyle,
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
                          textStyle: tendencyLabelStyle,
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
                          radius: (constraints.maxWidth / 2) * 0.88,
                          text: _viewModel.treatmentGoalLabel,
                          textStyle: sectionLabelStyle,
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
                          radius: (constraints.maxWidth / 2) * 0.88,
                          text: _viewModel.qualityOfLifeLabel,
                          textStyle: sectionLabelStyle,
                          startAngle: math.pi,
                          startAngleAlignment: StartAngleAlignment.center,
                          placement: Placement.outside,
                          direction: Direction.counterClockwise);
                    },
                  ),
                ),
              if (_viewModel.showTreatmentGoal)
                Positioned.fill(
                  child: AspectVisualizationOverlayArrow(
                    rotation: _viewModel.treatmentGoalArrowRotation,
                    color: treatmentGoalArrowColor,
                    strokeWidth: treatmentGoalArrowStrokeWidth,
                  ),
                ),
              Positioned.fill(
                child: AspectVisualizationOverlayArrow(
                  rotation: _viewModel.aspectEvaluationArrowRotation,
                  color: aspectEvaluationArrowColor,
                  strokeWidth: aspectEvaluationArrowStrokeWidth,
                ),
              ),
              Positioned.fill(child: LayoutBuilder(
                builder: (context, constraints) {
                  final Offset centerOfGestureDetector = Offset(constraints.maxWidth / 2, constraints.maxHeight / 2);
                  return GestureDetector(
                      onPanStart: (DragStartDetails details) =>
                          _handleMouseGestureEvent(details.localPosition, centerOfGestureDetector),
                      onPanUpdate: (DragUpdateDetails details) =>
                          _handleMouseGestureEvent(details.localPosition, centerOfGestureDetector));
                },
              )),
            ],
          ),
        ),
      ],
    );
  }

  void _handleMouseGestureEvent(Offset localPosition, Offset centerOfGestureDetector) {
    final touchPositionFromCenter = localPosition - centerOfGestureDetector;
    logger.v(
        'onPanUpdate $localPosition, center is $centerOfGestureDetector, touchPositionFromCenter $touchPositionFromCenter, direction ${touchPositionFromCenter.direction}');
    onDragAndRotate?.call(touchPositionFromCenter.direction);
  }
}

class AspectVisualizationOverlayArrow extends StatelessWidget {
  const AspectVisualizationOverlayArrow(
      {Key? key, required this.rotation, required this.strokeWidth, required this.color})
      : super(key: key);

  final double rotation;
  final Color color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final arrowScaleFactor = constraints.maxWidth / Constraints.aspectVisualizationConstraints.maxWidth;

      return Transform.rotate(
        angle: rotation,
        child: CustomPaint(
          painter: ArrowPainter(color: color, strokeWidth: strokeWidth * arrowScaleFactor),
        ),
      );
    });
  }
}

class ArrowPainter extends CustomPainter with Logging {
  ArrowPainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = strokeWidth;

    Path path = Path();
    path.moveTo(size.width * 0.24, size.height / 2);
    path.relativeLineTo(size.width * 0.63, 0);
    path = ArrowPath.make(path: path);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
