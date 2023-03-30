import 'dart:ui';

import 'package:flutter/material.dart';

class AspectVisualizationStyle extends ThemeExtension<AspectVisualizationStyle> {
  const AspectVisualizationStyle(
      {required this.sectionLabelStyle,
      required this.tendencyLabelStyle,
      required this.aspectEvaluationArrowStrokeWidth,
      required this.aspectEvaluationArrowColor,
      required this.treatmentGoalArrowStrokeWidth,
      required this.treatmentGoalArrowColor,
      required this.activeAspectCircleGradient,
      required this.inactiveAspectCircleGradient,
      required this.backgroundColor});

  final TextStyle? sectionLabelStyle;
  final TextStyle? tendencyLabelStyle;
  final double? aspectEvaluationArrowStrokeWidth;
  final Color? aspectEvaluationArrowColor;
  final double? treatmentGoalArrowStrokeWidth;
  final Color? treatmentGoalArrowColor;
  final Color? backgroundColor;
  final Gradient? activeAspectCircleGradient;
  final Gradient? inactiveAspectCircleGradient;

  @override
  AspectVisualizationStyle copyWith(
      {TextStyle? sectionLabelStyle,
      TextStyle? tendencyLabelStyle,
      double? aspectEvaluationArrowStrokeWidth,
      Color? aspectEvaluationArrowColor,
      double? treatmentGoalArrowStrokeWidth,
      Color? treatmentGoalArrowColor,
      Color? aspectCircleColor,
      Color? backgroundColor,
      Gradient? activeAspectCircleGradient,
      Gradient? inactiveAspectCircleGradient}) {
    return AspectVisualizationStyle(
        sectionLabelStyle: sectionLabelStyle ?? this.sectionLabelStyle,
        tendencyLabelStyle: tendencyLabelStyle ?? this.tendencyLabelStyle,
        aspectEvaluationArrowStrokeWidth: aspectEvaluationArrowStrokeWidth ?? this.aspectEvaluationArrowStrokeWidth,
        aspectEvaluationArrowColor: aspectEvaluationArrowColor ?? this.aspectEvaluationArrowColor,
        treatmentGoalArrowStrokeWidth: treatmentGoalArrowStrokeWidth ?? this.treatmentGoalArrowStrokeWidth,
        treatmentGoalArrowColor: treatmentGoalArrowColor ?? this.treatmentGoalArrowColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        activeAspectCircleGradient: activeAspectCircleGradient ?? this.activeAspectCircleGradient,
        inactiveAspectCircleGradient: inactiveAspectCircleGradient ?? this.inactiveAspectCircleGradient);
  }

  @override
  AspectVisualizationStyle lerp(ThemeExtension<AspectVisualizationStyle>? other, double t) {
    if (other is! AspectVisualizationStyle) {
      return this;
    }
    return AspectVisualizationStyle(
      sectionLabelStyle: TextStyle.lerp(sectionLabelStyle, other.sectionLabelStyle, t),
      tendencyLabelStyle: TextStyle.lerp(tendencyLabelStyle, other.tendencyLabelStyle, t),
      aspectEvaluationArrowStrokeWidth:
          lerpDouble(aspectEvaluationArrowStrokeWidth, other.aspectEvaluationArrowStrokeWidth, t),
      aspectEvaluationArrowColor: Color.lerp(aspectEvaluationArrowColor, other.aspectEvaluationArrowColor, t),
      treatmentGoalArrowStrokeWidth: lerpDouble(treatmentGoalArrowStrokeWidth, other.treatmentGoalArrowStrokeWidth, t),
      treatmentGoalArrowColor: Color.lerp(treatmentGoalArrowColor, other.treatmentGoalArrowColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      activeAspectCircleGradient: Gradient.lerp(activeAspectCircleGradient, other.activeAspectCircleGradient, t),
      inactiveAspectCircleGradient: Gradient.lerp(inactiveAspectCircleGradient, other.inactiveAspectCircleGradient, t),
    );
  }

  @override
  String toString() {
    return 'AspectVisualizationStyle{sectionLabelStyle: $sectionLabelStyle, tendencyLabelStyle: $tendencyLabelStyle, aspectEvaluationArrowStrokeWidth: $aspectEvaluationArrowStrokeWidth, aspectEvaluationArrowColor: $aspectEvaluationArrowColor, treatmentGoalArrowStrokeWidth: $treatmentGoalArrowStrokeWidth, treatmentGoalArrowColor: $treatmentGoalArrowColor, backgroundColor: $backgroundColor, activeAspectCircleGradient: $activeAspectCircleGradient, inactiveAspectCircleGradient: $inactiveAspectCircleGradient}';
  }
}
