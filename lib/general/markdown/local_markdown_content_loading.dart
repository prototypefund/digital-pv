import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

mixin LocalMarkdownContentLoading on ChangeNotifier {
  final Map<String, String> _cachedMarkdownContent = <String, String>{};

  Future<String> loadContentMarkdown(String assetLocation) async {
    _cachedMarkdownContent[assetLocation] = await rootBundle.loadString(assetLocation);
    notifyListeners();
    return cachedMarkdownContent(assetLocation);
  }

  String cachedMarkdownContent(String markdownPath) {
    return _cachedMarkdownContent[markdownPath] ?? '';
  }
}
