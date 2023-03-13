// ignore_for_file: avoid_dynamic_calls

import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/dynamic_content/json_serializable.dart';
import 'package:pd_app/general/dynamic_content/loading/cms_config.dart';

part 'cms_image.g.dart';

@JsonSerializable()
class CmsImage with SerializableAsset {
  CmsImage({required this.id, required this.name, required this.uri, required this.assetPath});

  factory CmsImage.fromJson(Map<String, dynamic> json) => _$CmsImageFromJson(json);

  factory CmsImage.fromCMSJson(Map<String, dynamic> attributesJson, {required CmsConfig cmsConfig}) {
    final imageUri = Uri.parse(attributesJson['data']['attributes']['url'] as String);
    final assetBasePath = cmsConfig.assetBasePath;
    String imageUriPath = imageUri.path;
    if (imageUriPath.startsWith("/")) {
      imageUriPath = imageUriPath.substring(1);
    }

    return CmsImage(
        id: attributesJson['data']['id'] as int,
        name: attributesJson['data']['attributes']['name'] as String,
        uri: cmsConfig.baseUri.replace(path: imageUri.path),
        assetPath: '$assetBasePath$imageUriPath');
  }

  final int id;

  final String name;

  final Uri uri;

  final String assetPath;

  @override
  Map<String, dynamic> toJson() => _$CmsImageToJson(this);
}
