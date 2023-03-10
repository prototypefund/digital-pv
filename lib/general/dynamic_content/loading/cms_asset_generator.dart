import 'dart:io';

import 'package:pd_app/general/dynamic_content/components/content_definition.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_loader.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_to_assets_cache.dart';
import 'package:pd_app/logging.dart';

class CmsAssetGenerator with Logging {
  CmsAssetGenerator(
      {required this.cmsDirectory,
      required this.scheme,
      required this.host,
      required this.port,
      required this.apiToken,
      required this.locales,
      required this.contentDefinitions});

  final String scheme;
  final String host;
  final int port;
  final String apiToken;
  final List<String> locales;
  final File cmsDirectory;
  final List<ContentDefinition> contentDefinitions;

  Future<void> createLocalAssetFiles() async {
    final loader = CMSLoader(scheme: scheme, host: host, port: port, apiToken: apiToken);

    final List<Future<LocalAssetFileCreationResult>> assetGenerationFutures = [];
    for (final String locale in locales) {
      for (final ContentDefinition definition in contentDefinitions) {
        assetGenerationFutures.add(
            _createLocalAssetFile(definition: definition, cmsDirectory: cmsDirectory, loader: loader, locale: locale));
      }
      logger.i('waiting for asset generation to complete');
      final List<LocalAssetFileCreationResult> results =
          await Future.wait<LocalAssetFileCreationResult>(assetGenerationFutures);

      final includedUris =
          results.map((e) => e.containedUris).fold<Set<Uri>>(<Uri>{}, (Set<Uri> previousValue, Set<Uri> newValue) {
        previousValue.addAll(newValue);
        return previousValue;
      });

      logger.i('there are ${includedUris.length} distinct uris in the cms dataset - will download them to assets');

      for (final uri in includedUris) {
        logger.d('downloading uri $uri');
        final mediaBytes = await loader.downloadMediaUri(uri);
        await CMSToAssetsCache().saveMediaToAssets(bytes: mediaBytes, baseUri: uri, baseDirectory: cmsDirectory);
      }

      logger.i('asset generation done');
    }
  }

  Future<LocalAssetFileCreationResult> _createLocalAssetFile(
      {required ContentDefinition definition,
      required File cmsDirectory,
      required CMSLoader loader,
      required String locale}) async {
    final loadingResult = await loader.loadEntitiesFromCMS(
        isSingleEntity: definition.isSingleEntity,
        locale: locale,
        entityName: definition.cmsEntityName,
        populateFields: definition.fieldsToPopulate.join(','),
        buildObjectFunction: definition.cmsLoadingFunction,
        queryParameters: definition.queryParameters);
    final entities = loadingResult.entities;

    await CMSToAssetsCache().saveEntitiesToAssets(
        baseDirectory: cmsDirectory, entities: entities, entityName: definition.localEntityName, locale: locale);

    return LocalAssetFileCreationResult(containedUris: loadingResult.containedUris);
  }
}
