import 'package:flutter/rendering.dart';

mixin Paddings {
  static const EdgeInsets headlinePadding = EdgeInsets.zero;
  static const EdgeInsets subHeadlinePadding = EdgeInsets.only(top: 32);
  static const EdgeInsets headlineExplanationPadding = EdgeInsets.only(top: 8);
  static const EdgeInsets emptyViewPadding = EdgeInsets.only(top: 64);
  static const EdgeInsets listPadding = EdgeInsets.only(top: 32);
  static const EdgeInsets sliderPadding = EdgeInsets.only(top: 5, bottom: 10);
  static const EdgeInsets newAspectSliderPadding = EdgeInsets.only(top: 35, bottom: 35);
  static const EdgeInsets listElementPadding = EdgeInsets.only(bottom: 4);
  static const EdgeInsets textFieldPadding = EdgeInsets.only(top: 16);
  static const EdgeInsets callToActionPadding = EdgeInsets.only(top: 16);
  static const EdgeInsets formSaveActionPadding = EdgeInsets.only(top: 32);
  static const EdgeInsets exampleButtonPadding = EdgeInsets.symmetric(horizontal: 2, vertical: 2);
  static const EdgeInsets floatingAspectVisualizationPadding = EdgeInsets.symmetric(horizontal: 32, vertical: 32);
}
