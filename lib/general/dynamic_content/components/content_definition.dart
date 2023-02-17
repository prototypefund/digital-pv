import 'package:pd_app/general/dynamic_content/json_serializable.dart';

class ContentDefinition<ContentClass extends SerializableAsset> {
  ContentDefinition(
      {required this.isSingleEntity,
      required this.cmsEntityName,
      required this.localEntityName,
      required this.fieldsToPopulate,
      required this.queryParameters,
      required this.buildObjectFunction});

  final bool isSingleEntity;
  final String cmsEntityName;
  final String localEntityName;
  final List<String> fieldsToPopulate;
  ContentClass Function(Map<String, dynamic> baseMap, Map<String, dynamic> attributeMap) buildObjectFunction;
  final Map<String, String> queryParameters;

  Type get contentClass => ContentClass;
}
