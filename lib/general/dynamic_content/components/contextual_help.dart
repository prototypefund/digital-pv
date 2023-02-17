import 'package:json_annotation/json_annotation.dart';

part 'contextual_help.g.dart';

@JsonSerializable()
class ContextualHelp {
  ContextualHelp({required this.id, required this.title, required this.content});

  factory ContextualHelp.fromJson(Map<String, dynamic> json) => _$ContextualHelpFromJson(json);

  final int id;
  final String? title;
  final String content;

  Map<String, dynamic> toJson() => _$ContextualHelpToJson(this);

  @override
  String toString() {
    return 'ContextualHelp{id: $id, title: $title, content: $content}';
  }
}
