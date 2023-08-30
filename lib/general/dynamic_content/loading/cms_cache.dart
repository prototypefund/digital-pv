import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pd_app/general/dynamic_content/components/content_definition.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_loader.dart';
import 'package:pd_app/general/dynamic_content/loading/json_serializable.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/logging.dart';

class CMSCache with Logging {
  CMSCache({required this.definitions});

  final List<ContentDefinition> definitions;

  final CMSLoader cmsLoader = getIt.get();

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

  Future<void> _loadEntitiesFromCMS({required String locale, required ContentDefinition contentDefinition}) async {
    final CmsLoadingResult result =
        await cmsLoader.loadEntitiesFromCMS(locale: locale, contentDefinition: contentDefinition);
    final List<dynamic> entityList = result.entities;

    logger.d('replacing cached for content definition ${contentDefinition.cmsEntityName} with content from cms');
    _cache[contentDefinition] = entityList;
  }

  Future<void> reloadAllFromAssets({required String locale}) async {
    logger.i('reloading all cms cache content from assets with locale $locale');
    final List<Future<void>> futures = [];
    for (final ContentDefinition definition in definitions) {
      futures.add(_loadEntitiesFromAssetCache(locale: locale, contentDefinition: definition));
    }
    await Future.wait<void>(futures);
    logger.i('reloading all cms cache content with locale $locale DONE');
  }

  Future<void> reloadAllFromCms({required String locale}) async {
    logger.i('reloading all cms cache content from cms with locale $locale');
    await Future.wait<void>(
      definitions.map(
        (definition) => _loadEntitiesFromCMS(locale: locale, contentDefinition: definition),
      ),
    );
    logger.i('reloading all cms cache content from cms with locale $locale DONE');
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
