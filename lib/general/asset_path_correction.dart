import 'package:flutter/foundation.dart';

mixin AssetPathCorrection {
  /// string assets need to have an assets/ in the beginning during tests
  /// but on the web assets/ must not be there and needs to be removed
  String correctAssetPath(String rawPath) {
    String assetLocation = rawPath;
    if (kIsWeb && assetLocation.startsWith('assets/')) {
      assetLocation = assetLocation.replaceFirst("assets/", "");
    }
    return assetLocation;
  }
}
