import 'package:pd_app/general/dynamic_content/loading/json_serializable.dart';

class ContentDefinition<ContentClass extends SerializableAsset> {
  ContentDefinition(
      {required this.isSingleEntity,
      required this.cmsEntityName,
      required this.localEntityName,
      required this.fieldsToPopulate,
      required this.queryParameters,
      required this.cmsLoadingFunction,
      required this.assetLoadingFunction});

  final bool isSingleEntity;
  final String cmsEntityName;
  final String localEntityName;
  final List<String> fieldsToPopulate;
  ContentClass Function(Map<String, dynamic> baseMap, Map<String, dynamic> attributeMap) cmsLoadingFunction;
  ContentClass Function(Map<String, dynamic>) assetLoadingFunction;
  final Map<String, String> queryParameters;

  Type get contentClass => ContentClass;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentDefinition && runtimeType == other.runtimeType && localEntityName == other.localEntityName;

  @override
  int get hashCode => localEntityName.hashCode;
}
