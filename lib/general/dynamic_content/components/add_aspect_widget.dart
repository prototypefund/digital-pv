import 'package:json_annotation/json_annotation.dart';

part 'add_aspect_widget.g.dart';

@JsonSerializable()
class AddAspectWidget {
  AddAspectWidget(
      {required this.emptyTextFieldHint,
      required this.lowSignificanceLabel,
      required this.highSignificanceLabel,
      required this.addAspectActionLabel});

  factory AddAspectWidget.fromJson(Map<String, dynamic> json) => _$AddAspectWidgetFromJson(json);

  @JsonKey(name: "empty_textfield_hint")
  final String emptyTextFieldHint;

  @JsonKey(name: "low_significance_label")
  final String lowSignificanceLabel;
  @JsonKey(name: "high_significance_label")
  final String highSignificanceLabel;
  @JsonKey(name: "add_aspect_action_label")
  final String addAspectActionLabel;

  Map<String, dynamic> toJson() => _$AddAspectWidgetToJson(this);
}
