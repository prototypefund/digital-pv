import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pd_app/logging.dart';

class CMSCache with Logging {
  Future<List<T>> loadEntitiesFromAssetCache<T>(
      {required String locale,
      required String entityName,
      required T Function(Map<String, dynamic>) loadingFunction}) async {
    final String key = 'assets/cms/$locale-$entityName.json';
    final String jsonString = await rootBundle.loadString(key);
    final List<dynamic> entityList = jsonDecode(jsonString) as List<dynamic>;

    final results = entityList.map((dynamic e) => loadingFunction(e as Map<String, dynamic>)).toList();

    logger.i('loaded ${results.length} cached entities from $key');
    return results;
  }
}
