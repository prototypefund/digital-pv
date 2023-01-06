import 'dart:ui';

import 'package:flutter/material.dart';

class DropdownButtonStyle extends ThemeExtension<DropdownButtonStyle> {
  const DropdownButtonStyle({required this.textStyle, required this.underlineColor, required this.underlineHeight});

  final TextStyle? textStyle;
  final Color? underlineColor;
  final double? underlineHeight;

  @override
  DropdownButtonStyle copyWith({TextStyle? textStyle, Color? underlineColor, double? underlineHeight}) {
    return DropdownButtonStyle(
      textStyle: textStyle ?? this.textStyle,
      underlineColor: underlineColor ?? this.underlineColor,
      underlineHeight: underlineHeight ?? this.underlineHeight,
    );
  }

  @override
  DropdownButtonStyle lerp(ThemeExtension<DropdownButtonStyle>? other, double t) {
    if (other is! DropdownButtonStyle) {
      return this;
    }
    return DropdownButtonStyle(
        textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
        underlineColor: Color.lerp(underlineColor, other.underlineColor, t),
        underlineHeight: lerpDouble(underlineHeight, other.underlineHeight, t));
  }

  @override
  String toString() {
    return 'DropdownButtonStyle{textStyle: $textStyle, underlineColor: $underlineColor, underlineHeight: $underlineHeight}';
  }
}
