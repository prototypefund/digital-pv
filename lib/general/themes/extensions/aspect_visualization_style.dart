import 'package:flutter/material.dart';

class AspectVisualizationStyle extends ThemeExtension<AspectVisualizationStyle> {
  const AspectVisualizationStyle({
    required this.sectionLabelStyle,
    required this.tendencyLabelStyle,
  });

  final TextStyle? sectionLabelStyle;
  final TextStyle? tendencyLabelStyle;

  @override
  AspectVisualizationStyle copyWith({
    TextStyle? sectionLabelStyle,
    TextStyle? tendencyLabelStyle,
  }) {
    return AspectVisualizationStyle(
        sectionLabelStyle: sectionLabelStyle ?? this.sectionLabelStyle,
        tendencyLabelStyle: tendencyLabelStyle ?? this.tendencyLabelStyle);
  }

  @override
  AspectVisualizationStyle lerp(ThemeExtension<AspectVisualizationStyle>? other, double t) {
    if (other is! AspectVisualizationStyle) {
      return this;
    }
    return AspectVisualizationStyle(
      sectionLabelStyle: TextStyle.lerp(sectionLabelStyle, other.sectionLabelStyle, t),
      tendencyLabelStyle: TextStyle.lerp(tendencyLabelStyle, other.tendencyLabelStyle, t),
    );
  }

  @override
  String toString() {
    return 'AspectVisualizationStyle{sectionLabelStyle: $sectionLabelStyle, tendencyLabelStyle: $tendencyLabelStyle}';
  }
}
