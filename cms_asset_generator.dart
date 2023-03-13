import 'dart:io';

import 'package:logger/logger.dart';
import 'package:pd_app/general/dynamic_content/content_definitions/cms_content_definitions.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_asset_generator.dart';

const List<String> locales = ['de', 'en'];

final Logger logger = Logger();

void main() async {
  final String? apiTokenFromEnv = Platform.environment['CMS_API_TOKEN'];

  if (apiTokenFromEnv != null) {
    final String apiToken = apiTokenFromEnv;
    final assetGenerator = CmsAssetGenerator(
        contentDefinitions: CmsConfiguration.definitions,
        cmsDirectory: File(CmsConfiguration.cmsConfig.assetBasePath),
        cmsConfig: CmsConfiguration.cmsConfig,
        apiToken: apiToken,
        locales: locales);
    await assetGenerator.createLocalAssetFiles();
  } else {
    logger.i('please specify the CMS API token using environment variable CMS_API_TOKEN');
  }
}
