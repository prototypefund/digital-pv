// ignore_for_file: avoid_dynamic_calls

import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/dynamic_content/json_serializable.dart';

part 'cms_image.g.dart';

@JsonSerializable()
class CmsImage with SerializableAsset {
  CmsImage({required this.id, required this.name, required this.uri});

  factory CmsImage.fromJson(Map<String, dynamic> json) => _$CmsImageFromJson(json);

  factory CmsImage.fromCMSJson(Map<String, dynamic> attributesJson) => CmsImage(
      id: attributesJson['data']['id'] as int,
      name: attributesJson['data']['attributes']['name'] as String,
      uri: Uri.parse(attributesJson['data']['attributes']['url'] as String));

  final int id;

  final String name;

  final Uri uri;

  @override
  Map<String, dynamic> toJson() => _$CmsImageToJson(this);
}
