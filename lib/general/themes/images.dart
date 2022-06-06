import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

mixin Images {
  static const String _backgroundDecorationPath = 'images/background.svg';

  static AssetImage backgroundDecoration() => AssetImage(backgroundDecorationPath());

  static String backgroundDecorationPath() => _buildAssetPathBasedOnPlattform(rawPath: _backgroundDecorationPath);

  /// See https://stackoverflow.com/questions/61301598/how-can-i-display-asset-images-on-flutter-web for the reason this exists
  ///
  /// tldr: Flutter Web needs an additional '/assets' prefix for its asset paths. Widget tests ail without this
  static String _buildAssetPathBasedOnPlattform({required String rawPath}) {
    if (!kIsWeb) {
      return 'assets/$rawPath';
    } else {
      return rawPath;
    }
  }
}
