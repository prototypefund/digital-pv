class AspectCircleSizeController {
  AspectCircleSizeController.positiveAspects()
      : minMaxSizeDifference = _minMaxSizeDifferenceFactor,
        sizeMultiplier = _sizeMultiplier;

  AspectCircleSizeController.negativeAspects()
      : minMaxSizeDifference = _minMaxSizeDifferenceFactor,
        sizeMultiplier = _sizeMultiplier;

  AspectCircleSizeController.futureAspects()
      : minMaxSizeDifference = _minMaxSizeDifferenceFactor,
        sizeMultiplier = _sizeMultiplier;

  /// factor that define the difference in circle sizes between the least and the most valuable aspect
  /// as bigger is @minMaxSizeDifference as smaller the difference
  ///
  /// Important!!!
  /// @minMaxSizeDifference also affects the general sizes of circles
  /// if you change @_minMaxSizeDifference constants you have to adjust the @_sizeMultiplier constants as well
  final double minMaxSizeDifference;

  /// general factor for circle size
  ///
  /// as bigger the @sizeMultiplier as bigger are the circles
  ///
  /// @sizeMultiplier is independent from @minMaxSizeDifference
  /// that means that you change @sizeMultiplier without adjusting @minMaxSizeDifference
  final double sizeMultiplier;

  static const double _minMaxSizeDifferenceFactor = 0.9;
  static const double _sizeMultiplier = 10.0;
}
