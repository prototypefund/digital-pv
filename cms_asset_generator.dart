import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:pd_app/general/dynamic_content/cms_content_definitions.dart';
import 'package:pd_app/general/dynamic_content/components/content_definition.dart';
import 'package:pd_app/general/dynamic_content/json_serializable.dart';
import 'package:pd_app/logging.dart';

const List<String> locales = ['de', 'en'];

final Logger logger = Logger();

class CMSToAssetsCache with Logging {
  Future<void> saveEntitiesToAssets(
      {required List<SerializableAsset> entities,
      required String locale,
      required String entityName,
      required File baseDirectory}) async {
    final File destinationFile = File('${baseDirectory.path}$locale-$entityName.json');
    logger.i('saving ${entities.length} cached entities to $destinationFile');

    final String json = jsonEncode(entities.map((e) => e.toJson()).toList());
    if (!destinationFile.existsSync()) {
      logger.d('creating file $destinationFile');
      await destinationFile.create(recursive: true);
    }
    await destinationFile.writeAsString(json);
  }
}

class CMSLoader with Logging {
  CMSLoader({required this.scheme, required this.host, required this.port, required this.apiToken});

  final String scheme;
  final String host;
  final int port;
  final String apiToken;

  Future<List<T>> loadEntitiesFromCMS<T>(
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
    if (isSingleEntity) {
      dataItems = <dynamic>[responseJson['data'] as Map<String, dynamic>];
    } else {
      dataItems = responseJson['data'] as List<dynamic>;
    }

    final List<T> results = dataItems.map((dynamic e) => buildObjectFunction(_baseMap(e), _attributesMap(e))).toList();

    return results;
  }

  static Map<String, dynamic> _baseMap(dynamic cmsJson) {
    return cmsJson as Map<String, dynamic>;
  }

  static Map<String, dynamic> _attributesMap(dynamic cmsJson) {
    final Map<String, dynamic> baseJson = _baseMap(cmsJson);
    return baseJson['attributes'] as Map<String, dynamic>;
  }
}

void main() async {
  final String? apiTokenFromEnv = Platform.environment['CMS_API_TOKEN'];

  if (apiTokenFromEnv != null) {
    final String apiToken = apiTokenFromEnv;
    await _createLocalAssetFiles(apiToken);
  } else {
    logger.i('please specify the CMS API token using environment variable CMS_API_TOKEN');
  }
}

Future<void> _createLocalAssetFiles(String apiToken) async {
  final loader = CMSLoader(scheme: 'https', host: 'strapi.dpv.staging.deyan7.de', port: 443, apiToken: apiToken);
  final cmsDirectory = File('assets/cms/');

  final List<Future> assetGenerationFutures = [];
  for (final String locale in locales) {
    for (final ContentDefinition definition in CmsContentDefinitions.definitions) {
      assetGenerationFutures.add(
          _createLocalAssetFile(definition: definition, cmsDirectory: cmsDirectory, loader: loader, locale: locale));
    }
    logger.i('waiting for asset generation to complete');
    await Future.wait<void>(assetGenerationFutures);

    logger.i('asset generation done');
  }
}

Future<void> _createLocalAssetFile(
    {required ContentDefinition definition,
    required File cmsDirectory,
    required CMSLoader loader,
    required String locale}) async {
  await CMSToAssetsCache().saveEntitiesToAssets(
      baseDirectory: cmsDirectory,
      entities: await loader.loadEntitiesFromCMS(
          isSingleEntity: definition.isSingleEntity,
          locale: locale,
          entityName: definition.cmsEntityName,
          populateFields: definition.fieldsToPopulate.join(','),
          buildObjectFunction: definition.cmsLoadingFunction,
          queryParameters: definition.queryParameters),
      entityName: definition.localEntityName,
      locale: locale);
}
