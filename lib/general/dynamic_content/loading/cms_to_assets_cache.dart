import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:pd_app/general/dynamic_content/json_serializable.dart';
import 'package:pd_app/logging.dart';

class CMSToAssetsCache with Logging {
  Future<void> saveMediaToAssets({required Uint8List bytes, required Uri baseUri, required File baseDirectory}) async {
    final File destinationFile = File('${baseDirectory.path}${baseUri.path}');
    await destinationFile.create(recursive: true);
    logger.d('saving media to file $destinationFile');
    await destinationFile.writeAsBytes(bytes);
  }

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
