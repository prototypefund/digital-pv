// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aspect_list_widget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AspectListWidget _$AspectListWidgetFromJson(Map<String, dynamic> json) => AspectListWidget(
      deleteConfirmationQuestion: json['delete_confirmation_question'] as String,
      lowSignificanceLabel: json['low_significance_label'] as String,
      highSignificanceLabel: json['high_significance_label'] as String,
      deleteConfirmationCancel: json['delete_confirmation_cancel'] as String,
      deleteConfirmationConfirm: json['delete_confirmation_confirm'] as String,
      emptyListMessage: json['empty_list_message'] as String,
      simulateAspectLabel: json['simulate_aspect_label'] as String?,
    );

Map<String, dynamic> _$AspectListWidgetToJson(AspectListWidget instance) => <String, dynamic>{
      'delete_confirmation_question': instance.deleteConfirmationQuestion,
      'delete_confirmation_cancel': instance.deleteConfirmationCancel,
      'delete_confirmation_confirm': instance.deleteConfirmationConfirm,
      'low_significance_label': instance.lowSignificanceLabel,
      'high_significance_label': instance.highSignificanceLabel,
      'empty_list_message': instance.emptyListMessage,
      'simulate_aspect_label': instance.simulateAspectLabel,
    };
