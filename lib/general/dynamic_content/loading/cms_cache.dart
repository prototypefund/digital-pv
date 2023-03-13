import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pd_app/general/dynamic_content/components/content_definition.dart';
import 'package:pd_app/general/dynamic_content/loading/json_serializable.dart';
import 'package:pd_app/logging.dart';

class CMSCache with Logging {
  CMSCache({required this.definitions});

  final List<ContentDefinition> definitions;

  final Map<ContentDefinition, List<dynamic>> _cache = {};

  Future<void> _loadEntitiesFromAssetCache(
      {required String locale, required ContentDefinition contentDefinition}) async {
    final String key = 'assets/cms/$locale-${contentDefinition.localEntityName}.json';
    final String jsonString = await rootBundle.loadString(key);
    final List<dynamic> entityList = jsonDecode(jsonString) as List<dynamic>;

    final results =
        entityList.map((dynamic e) => contentDefinition.assetLoadingFunction(e as Map<String, dynamic>)).toList();

    logger.i('loaded ${results.length} cached entities from $key');

    _cache[contentDefinition] = results;
  }

  Future<void> reloadAll({required String locale}) async {
    logger.i('reloading all cms cache content with locale $locale');
    final List<Future<void>> futures = [];
    for (final ContentDefinition definition in definitions) {
      futures.add(_loadEntitiesFromAssetCache(locale: locale, contentDefinition: definition));
    }
    await Future.wait<void>(futures);
    logger.i('reloading all cms cache content with locale $locale DONE');
  }

  List<T> value<T extends SerializableAsset>(
      {required ContentDefinition<T> contentDefinition, required List<T> defaultValue}) {
    final List<dynamic>? cacheValue = _cache[contentDefinition];

    if (cacheValue == null) {
      return defaultValue;
    } else {
      return cacheValue.whereType<T>().toList();
    }
  }
}
