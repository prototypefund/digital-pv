import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:pd_app/general/dynamic_content/components/content_definition.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_config.dart';
import 'package:pd_app/general/dynamic_content/loading/json_serializable.dart';
import 'package:pd_app/logging.dart';

class CMSLoader with Logging {
  CMSLoader({required this.cmsConfig, required this.apiToken});

  final CmsConfig cmsConfig;
  final String apiToken;

  Future<CmsLoadingResult<T>> loadEntitiesFromCMS<T extends SerializableAsset>(
      {required String locale, required ContentDefinition<T> contentDefinition}) async {
    final isSingleEntity = contentDefinition.isSingleEntity;
    final entityName = contentDefinition.cmsEntityName;
    final populateFields = contentDefinition.fieldsToPopulate.join(',');
    final buildObjectFunction = contentDefinition.cmsLoadingFunction;
    final queryParameters = contentDefinition.queryParameters;

    final headers = {
      'accept': "application/json",
      "authorization": "Bearer $apiToken",
    };
    final Map<String, String> completeQueryParameters = {
      "populate": populateFields,
      'locale': locale,
    };
    completeQueryParameters.addAll(queryParameters);

    final requestUri = Uri(
      path: "api/$entityName",
      scheme: cmsConfig.baseUri.scheme,
      host: cmsConfig.baseUri.host,
      port: cmsConfig.baseUri.port,
      queryParameters: completeQueryParameters,
    );

    final response = await http.get(requestUri, headers: headers);
    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
    final List<dynamic> dataItems = isSingleEntity
        ? <dynamic>[responseJson['data'] as Map<String, dynamic>]
        : responseJson['data'] as List<dynamic>;

    final Set<Uri> parsedUris = dataItems
        .whereType<Map<String, dynamic>>()
        .map<Set<Uri>>(findIncludedUris)
        .fold<Set<Uri>>(<Uri>{}, (previousValue, newValue) {
      previousValue.addAll(newValue);
      return previousValue;
    });

    final List<T> results = dataItems
        .whereType<Map<String, dynamic>>()
        .map<T>((dynamic e) => buildObjectFunction(_baseMap(e), _attributesMap(e)))
        .toList();

    return CmsLoadingResult(entities: results, containedUris: parsedUris);
  }

  static Set<Uri> findIncludedUris(Map<String, dynamic> jsonMap) {
    final result = <Uri>{};

    for (final String key in jsonMap.keys) {
      final dynamic value = jsonMap[key];
      if (key == "url" && value is String) {
        final parsedUri = Uri.tryParse(value);
        if (parsedUri != null) {
          result.add(parsedUri);
        }
      }
      if (value is Map<String, dynamic>) {
        result.addAll(findIncludedUris(value));
      }
      if (value is List<dynamic>) {
        for (final listEntry in value) {
          if (listEntry is Map<String, dynamic>) {
            result.addAll(findIncludedUris(listEntry));
          }
        }
      }
    }
    return result;
  }

  static Map<String, dynamic> _baseMap(dynamic cmsJson) {
    return cmsJson as Map<String, dynamic>;
  }

  static Map<String, dynamic> _attributesMap(dynamic cmsJson) {
    final Map<String, dynamic> baseJson = _baseMap(cmsJson);
    return baseJson['attributes'] as Map<String, dynamic>;
  }

  Future<Uint8List> downloadMediaUri(Uri uri) async {
    final headers = {"authorization": "Bearer $apiToken"};

    final requestUri = Uri(
        path: uri.path, scheme: cmsConfig.baseUri.scheme, host: cmsConfig.baseUri.host, port: cmsConfig.baseUri.port);

    logger.d('requesting image $uri');
    final response = await http.get(requestUri, headers: headers);

    logger.d('got response status code ${response.statusCode} for uri $uri');

    return response.bodyBytes;
  }
}

class CmsLoadingResult<T> {
  CmsLoadingResult({required this.entities, required this.containedUris});

  final List<T> entities;
  final Set<Uri> containedUris;
}

class LocalAssetFileCreationResult {
  LocalAssetFileCreationResult({required this.containedUris});

  final Set<Uri> containedUris;
}
