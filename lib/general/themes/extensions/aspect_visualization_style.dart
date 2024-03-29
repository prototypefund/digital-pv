import 'dart:ui';

import 'package:flutter/material.dart';

class AspectVisualizationStyle extends ThemeExtension<AspectVisualizationStyle> {
  const AspectVisualizationStyle({
    required this.sectionLabelStyle,
    required this.tendencyLabelStyle,
    required this.aspectEvaluationArrowStrokeWidth,
    required this.aspectEvaluationArrowColor,
    required this.treatmentGoalArrowStrokeWidth,
    required this.treatmentGoalArrowColor,
  });

  final TextStyle? sectionLabelStyle;
  final TextStyle? tendencyLabelStyle;
  final double? aspectEvaluationArrowStrokeWidth;
  final Color? aspectEvaluationArrowColor;
  final double? treatmentGoalArrowStrokeWidth;
  final Color? treatmentGoalArrowColor;

  @override
  AspectVisualizationStyle copyWith(
      {TextStyle? sectionLabelStyle,
      TextStyle? tendencyLabelStyle,
      double? aspectEvaluationArrowStrokeWidth,
      Color? aspectEvaluationArrowColor,
      double? treatmentGoalArrowStrokeWidth,
      Color? treatmentGoalArrowColor}) {
    return AspectVisualizationStyle(
        sectionLabelStyle: sectionLabelStyle ?? this.sectionLabelStyle,
        tendencyLabelStyle: tendencyLabelStyle ?? this.tendencyLabelStyle,
        aspectEvaluationArrowStrokeWidth: aspectEvaluationArrowStrokeWidth ?? this.aspectEvaluationArrowStrokeWidth,
        aspectEvaluationArrowColor: aspectEvaluationArrowColor ?? this.aspectEvaluationArrowColor,
        treatmentGoalArrowStrokeWidth: treatmentGoalArrowStrokeWidth ?? this.treatmentGoalArrowStrokeWidth,
        treatmentGoalArrowColor: treatmentGoalArrowColor ?? this.treatmentGoalArrowColor);
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
    );
  }

  @override
  String toString() {
    return 'AspectVisualizationStyle{sectionLabelStyle: $sectionLabelStyle, tendencyLabelStyle: $tendencyLabelStyle}';
  }
}
