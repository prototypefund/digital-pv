import 'package:flutter/material.dart';

class PageIndicatorStyle extends ThemeExtension<PageIndicatorStyle> {
  const PageIndicatorStyle({required this.decoration});

  final BoxDecoration? decoration;

  @override
  PageIndicatorStyle copyWith({BoxDecoration? decoration}) {
    return PageIndicatorStyle(
      decoration: decoration ?? this.decoration,
    );
  }

  @override
  PageIndicatorStyle lerp(ThemeExtension<PageIndicatorStyle>? other, double t) {
    if (other is! PageIndicatorStyle) {
      return this;
    }
    return PageIndicatorStyle(decoration: BoxDecoration.lerp(decoration, other.decoration, t));
  }

  @override
  String toString() => 'PageIndicatorStyle(decoration: $decoration)';
}
