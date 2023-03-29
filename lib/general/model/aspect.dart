import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/model/weight.dart';

part 'aspect.g.dart';

@JsonSerializable()
class Aspect {
  Aspect({required this.name, this.description, required this.weight});

  factory Aspect.fromJson(Map<String, dynamic> json) => _$AspectFromJson(json);

  final String name;
  final String? description;
  Weight weight;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Aspect &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          weight == other.weight;

  @override
  int get hashCode => name.hashCode ^ description.hashCode ^ weight.hashCode;

  Map<String, dynamic> toJson() => _$AspectToJson(this);

  @override
  String toString() {
    return 'Aspect{name: $name, description: $description, weight: $weight}';
  }
}
