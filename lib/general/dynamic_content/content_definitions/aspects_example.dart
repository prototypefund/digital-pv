import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/dynamic_content/components/example.dart';
import 'package:pd_app/general/dynamic_content/loading/json_serializable.dart';

part 'aspects_example.g.dart';

@JsonSerializable()
class AspectsExample with SerializableAsset {
  AspectsExample({required this.example, required this.id, required this.locale});

  factory AspectsExample.fromJson(Map<String, dynamic> json) => _$AspectsExampleFromJson(json);

  factory AspectsExample.fromCMSJson(Map<String, dynamic> baseJson, Map<String, dynamic> attributesJson) =>
      AspectsExample(
          example: Example.fromJson(attributesJson['example'] as Map<String, dynamic>),
          id: baseJson['id'] as int,
          locale: attributesJson['locale'] as String);

  final Example example;

  final int id;

  final String locale;

  @override
  Map<String, dynamic> toJson() => _$AspectsExampleToJson(this);

  @override
  String toString() {
    return 'AspectsExample{example: $example, id: $id, locale: $locale}';
  }
}
