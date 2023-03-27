import 'package:json_annotation/json_annotation.dart';

part 'aspect_list_widget.g.dart';

@JsonSerializable()
class AspectListWidget {
  AspectListWidget(
      {required this.deleteConfirmationQuestion,
      required this.lowSignificanceLabel,
      required this.highSignificanceLabel,
      required this.deleteConfirmationCancel,
      required this.deleteConfirmationConfirm,
      required this.emptyListMessage});

  factory AspectListWidget.fromJson(Map<String, dynamic> json) => _$AspectListWidgetFromJson(json);

  @JsonKey(name: "delete_confirmation_question")
  final String deleteConfirmationQuestion;
  @JsonKey(name: "delete_confirmation_cancel")
  final String deleteConfirmationCancel;
  @JsonKey(name: "delete_confirmation_confirm")
  final String deleteConfirmationConfirm;

  @JsonKey(name: "low_significance_label")
  final String lowSignificanceLabel;
  @JsonKey(name: "high_significance_label")
  final String highSignificanceLabel;
  @JsonKey(name: "empty_list_message")
  final String emptyListMessage;

  Map<String, dynamic> toJson() => _$AspectListWidgetToJson(this);
}
