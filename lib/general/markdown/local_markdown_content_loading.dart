import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pd_app/general/asset_path_correction.dart';

mixin LocalMarkdownContentLoading on AssetPathCorrection, ChangeNotifier {
  final Map<String, String> _cachedMarkdownContent = <String, String>{};

  Future<String> loadContentMarkdown(String markdownPath) async {
    final assetLocation = correctAssetPath(markdownPath);
    _cachedMarkdownContent[markdownPath] = await rootBundle.loadString(assetLocation);
    notifyListeners();
    return cachedMarkdownContent(markdownPath);
  }

  String cachedMarkdownContent(String markdownPath) {
    return _cachedMarkdownContent[markdownPath] ?? '';
  }
}
