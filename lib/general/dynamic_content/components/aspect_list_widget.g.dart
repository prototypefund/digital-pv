// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aspect_list_widget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AspectListWidget _$AspectListWidgetFromJson(Map<String, dynamic> json) => AspectListWidget(
      deleteConfirmationQuestion: json['delete_confirmation_question'] as String,
      lowSignificanceLabel: json['low_significance_label'] as String,
      highSignificanceLabel: json['high_significance_label'] as String,
      emptyListMessage: json['empty_list_message'] as String,
    );

Map<String, dynamic> _$AspectListWidgetToJson(AspectListWidget instance) => <String, dynamic>{
      'delete_confirmation_question': instance.deleteConfirmationQuestion,
      'low_significance_label': instance.lowSignificanceLabel,
      'high_significance_label': instance.highSignificanceLabel,
      'empty_list_message': instance.emptyListMessage,
    };
