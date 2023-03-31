import 'dart:math' as math;

import 'package:arrow_path/arrow_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pd_app/general/model/future_situation.dart';
// ignore: unused_import
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/themes/constraints.dart';
import 'package:pd_app/general/themes/extensions/aspect_visualization_style.dart';
import 'package:pd_app/general/view_components/directive_visualization/aspects_visualization.dart';
import 'package:pd_app/general/view_components/directive_visualization/directive_visualization_view_model.dart';
import 'package:pd_app/logging.dart';
import 'package:provider/provider.dart';

class DirectiveVisualization extends StatelessWidget with Logging {
  const DirectiveVisualization({super.key, this.onDragAndRotate});

  final ValueChanged<double>? onDragAndRotate;

  static Widget widgetWithViewModel(
          {required bool showLabels,
          required bool showTreatmentGoal,
          ValueChanged<double>? onDragAndRotate,
          required bool simulateFutureAspects}) =>
      ChangeNotifierProvider(
          create: (_) => DirectiveVisualizationViewModel(
              showLabels: showLabels,
              showTreatmentGoal: showTreatmentGoal,
              simulateFutureAspects: simulateFutureAspects),
          child: DirectiveVisualization(
            onDragAndRotate: onDragAndRotate,
          ));

  @override
  Widget build(BuildContext context) {
    final DirectiveVisualizationViewModel viewModel = context.watch();

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
    final activeAspectCircleGradient =
        Theme.of(context).extension<AspectVisualizationStyle>()!.activeAspectCircleGradient ??
            const RadialGradient(colors: [Colors.white, Colors.black]);
    final inactiveAspectCircleGradient =
        Theme.of(context).extension<AspectVisualizationStyle>()!.inactiveAspectCircleGradient ??
            const RadialGradient(colors: [Colors.white, Colors.black]);
    final compassBackground = Theme.of(context).extension<AspectVisualizationStyle>()!.backgroundColor ?? Colors.white;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(color: compassBackground, shape: BoxShape.circle),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: SvgPicture.asset(
                    viewModel.evaluationImageBackground,
                  ),
                ),
              ),
              if (viewModel.showLabels)
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ArcText(
                          radius: (constraints.maxWidth / 2) * 0.88,
                          text: viewModel.palliativeLabel,
                          textStyle: tendencyLabelStyle,
                          startAngle: (-math.pi / 2) + 0.1,
                          startAngleAlignment: StartAngleAlignment.start,
                          placement: Placement.outside,
                          direction: Direction.clockwise);
                    },
                  ),
                ),
              if (viewModel.showLabels)
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ArcText(
                          radius: (constraints.maxWidth / 2) * 0.88,
                          text: viewModel.curativeLabel,
                          textStyle: tendencyLabelStyle,
                          startAngle: (math.pi / 2) - 0.1,
                          startAngleAlignment: StartAngleAlignment.end,
                          placement: Placement.outside,
                          direction: Direction.clockwise);
                    },
                  ),
                ),
              if (viewModel.showLabels)
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ArcText(
                          radius: (constraints.maxWidth / 2) * 0.88,
                          text: viewModel.negativeLabel,
                          textStyle: tendencyLabelStyle,
                          startAngle: (math.pi / 2) + 0.1,
                          startAngleAlignment: StartAngleAlignment.start,
                          placement: Placement.outside,
                          direction: Direction.clockwise);
                    },
                  ),
                ),
              if (viewModel.showLabels)
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ArcText(
                          radius: (constraints.maxWidth / 2) * 0.88,
                          text: viewModel.positiveLabel,
                          textStyle: tendencyLabelStyle,
                          startAngle: (-math.pi / 2) - 0.1,
                          startAngleAlignment: StartAngleAlignment.end,
                          placement: Placement.outside,
                          direction: Direction.clockwise);
                    },
                  ),
                ),
              if (viewModel.showLabels)
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ArcText(
                          radius: (constraints.maxWidth / 2) * 0.88,
                          text: viewModel.treatmentGoalLabel,
                          textStyle: sectionLabelStyle,
                          startAngle: 0,
                          startAngleAlignment: StartAngleAlignment.center,
                          placement: Placement.outside,
                          direction: Direction.clockwise);
                    },
                  ),
                ),
              if (viewModel.showLabels)
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ArcText(
                          radius: (constraints.maxWidth / 2) * 0.88,
                          text: viewModel.qualityOfLifeLabel,
                          textStyle: sectionLabelStyle,
                          startAngle: math.pi,
                          startAngleAlignment: StartAngleAlignment.center,
                          placement: Placement.outside,
                          direction: Direction.counterClockwise);
                    },
                  ),
                ),
              if (viewModel.showTreatmentGoal)
                Positioned.fill(
                  child: AspectVisualizationOverlayArrow(
                    rotation: viewModel.treatmentGoalArrowRotation,
                    color: treatmentGoalArrowColor,
                    strokeWidth: treatmentGoalArrowStrokeWidth,
                  ),
                ),
              // Positioned.fill(
              //   child: AspectVisualizationOverlayArrow(
              //     rotation: viewModel.aspectEvaluationArrowRotation,
              //     color: aspectEvaluationArrowColor,
              //     strokeWidth: aspectEvaluationArrowStrokeWidth,
              //   ),
              // ),
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

              /// positive aspects
              Positioned.fill(
                child: AspectsVisualization(
                  aspects: viewModel.positiveAspects,
                  angleForVisualisation: viewModel.aspectEvaluationArrowRotation,
                  activeAspectCircleGradient: activeAspectCircleGradient,
                  simulateFutureAspects: viewModel.simulateFutureAspects,
                  inactiveAspectCircleGradient: inactiveAspectCircleGradient,
                  onAspectTapped: (aspect) => viewModel.onPositiveAspectTapped(context, aspect),
                ),
              ),

              /// negative aspects
              Positioned.fill(
                child: Transform.rotate(
                  angle: viewModel.aspectEvaluationArrowRotation,
                  child: AspectsVisualization(
                    aspects: viewModel.negativeAspects,
                    angleForVisualisation: math.pi - viewModel.aspectEvaluationArrowRotation,
                    simulateFutureAspects: viewModel.simulateFutureAspects,
                    activeAspectCircleGradient: activeAspectCircleGradient,
                    inactiveAspectCircleGradient: inactiveAspectCircleGradient,
                    onAspectTapped: (aspect) => viewModel.onNegativeAspectTapped(context, aspect),
                  ),
                ),
              ),

              /// future aspects
              Positioned.fill(
                child: Transform.rotate(
                  angle: math.pi,
                  child: AspectsVisualization(
                    aspects: viewModel.futureAspects,
                    angleForVisualisation: math.pi,
                    activeAspectCircleGradient: activeAspectCircleGradient,
                    simulateFutureAspects: viewModel.simulateFutureAspects,
                    inactiveAspectCircleGradient: inactiveAspectCircleGradient,
                    onAspectTapped: (aspect) => viewModel.onFutureAspectTapped(context, aspect as FutureSituation),
                  ),
                ),
              ),
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

class AspectVisualizationOverlayArrow extends StatelessWidget with Logging {
  const AspectVisualizationOverlayArrow(
      {super.key, required this.rotation, required this.strokeWidth, required this.color});

  final double rotation;
  final Color color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      logger.v('building scaled arrow with constraints $constraints');
      final arrowScaleFactor = (constraints.maxWidth) / Constraints.aspectVisualizationConstraints.maxWidth;

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
