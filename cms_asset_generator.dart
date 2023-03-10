import 'dart:io';

import 'package:logger/logger.dart';
import 'package:pd_app/general/dynamic_content/cms_content_definitions.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_asset_generator.dart';

const List<String> locales = ['de', 'en'];

final Logger logger = Logger();

const String scheme = 'https';
const String host = 'strapi.dpv.staging.deyan7.de';
const int port = 443;
const String cmsDirectoryPath = 'assets/cms/';

void main() async {
  final String? apiTokenFromEnv = Platform.environment['CMS_API_TOKEN'];

  if (apiTokenFromEnv != null) {
    final String apiToken = apiTokenFromEnv;
    final assetGenerator = CmsAssetGenerator(
        contentDefinitions: CmsContentDefinitions.definitions,
        cmsDirectory: File(cmsDirectoryPath),
        scheme: scheme,
        host: host,
        port: port,
        apiToken: apiToken,
        locales: locales);
    await assetGenerator.createLocalAssetFiles();
  } else {
    logger.i('please specify the CMS API token using environment variable CMS_API_TOKEN');
  }
}
