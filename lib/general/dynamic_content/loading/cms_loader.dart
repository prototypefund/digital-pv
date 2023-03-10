import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:pd_app/logging.dart';

class CMSLoader with Logging {
  CMSLoader({required this.scheme, required this.host, required this.port, required this.apiToken});

  final String scheme;
  final String host;
  final int port;
  final String apiToken;

  Future<CmsLoadingResult<T>> loadEntitiesFromCMS<T>(
      {required String locale,
      required String entityName,
      required String populateFields,
      bool isSingleEntity = false,
      Map<String, String> queryParameters = const {},
      required T Function(Map<String, dynamic> baseMap, Map<String, dynamic> attributeMap) buildObjectFunction}) async {
    final headers = {'accept': "application/json", "authorization": "Bearer $apiToken"};
    final Map<String, String> completeQueryParameters = <String, String>{"populate": populateFields, 'locale': locale};
    completeQueryParameters.addAll(queryParameters);

    final requestUri =
        Uri(path: "api/$entityName", scheme: scheme, host: host, port: port, queryParameters: completeQueryParameters);

    final response = await http.get(requestUri, headers: headers);

    final Map<String, dynamic> responseJson = jsonDecode(response.body) as Map<String, dynamic>;
    final List<dynamic> dataItems;
    final Set<Uri> parsedUris;
    if (isSingleEntity) {
      final jsonData = responseJson['data'] as Map<String, dynamic>;
      dataItems = <dynamic>[jsonData];
      parsedUris = findIncludedUris(jsonData);
    } else {
      dataItems = responseJson['data'] as List<dynamic>;
      parsedUris = dataItems
          .whereType<Map<String, dynamic>>()
          .map<Set<Uri>>((e) => findIncludedUris(e))
          .fold<Set<Uri>>(<Uri>{}, (Set<Uri> previousValue, Set<Uri> newValue) {
        previousValue.addAll(newValue);
        return previousValue;
      });
    }

    final List<T> results = dataItems.map((dynamic e) => buildObjectFunction(_baseMap(e), _attributesMap(e))).toList();

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

    final requestUri = Uri(path: uri.path, scheme: scheme, host: host, port: port);

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
