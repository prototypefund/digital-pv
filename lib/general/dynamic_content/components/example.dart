import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/dynamic_content/components/contextual_help.dart';

part 'example.g.dart';

@JsonSerializable()
class Example {
  Example({required this.id, required this.group, required this.title, required this.contextualHelp});

  factory Example.fromJson(Map<String, dynamic> json) => _$ExampleFromJson(json);

  final int id;
  final String group;
  final String title;

  @JsonKey(name: 'contextual_help')
  final ContextualHelp? contextualHelp;

  Map<String, dynamic> toJson() => _$ExampleToJson(this);

  @override
  String toString() {
    return 'Example{id: $id, group: $group, title: $title, contextualHelp: $contextualHelp}';
  }
}
