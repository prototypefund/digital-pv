// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cms_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CmsImage _$CmsImageFromJson(Map<String, dynamic> json) => CmsImage(
      id: json['id'] as int,
      name: json['name'] as String,
      uri: Uri.parse(json['uri'] as String),
      assetPath: json['assetPath'] as String,
    );

Map<String, dynamic> _$CmsImageToJson(CmsImage instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'uri': instance.uri.toString(),
      'assetPath': instance.assetPath,
    };
