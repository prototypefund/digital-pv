// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'future_situation.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FutureSituationCWProxy {
  FutureSituation name(String name);

  FutureSituation weight(Weight weight);

  FutureSituation treatmentActivitiyPreferences(List<TreatmentActivityPreference> treatmentActivitiyPreferences);

  FutureSituation simulateAspect(bool simulateAspect);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FutureSituation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FutureSituation(...).copyWith(id: 12, name: "My name")
  /// ````
  FutureSituation call({
    String? name,
    Weight? weight,
    List<TreatmentActivityPreference>? treatmentActivitiyPreferences,
    bool? simulateAspect,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFutureSituation.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFutureSituation.copyWith.fieldName(...)`
class _$FutureSituationCWProxyImpl implements _$FutureSituationCWProxy {
  const _$FutureSituationCWProxyImpl(this._value);

  final FutureSituation _value;

  @override
  FutureSituation name(String name) => this(name: name);

  @override
  FutureSituation weight(Weight weight) => this(weight: weight);

  @override
  FutureSituation treatmentActivitiyPreferences(List<TreatmentActivityPreference> treatmentActivitiyPreferences) =>
      this(treatmentActivitiyPreferences: treatmentActivitiyPreferences);

  @override
  FutureSituation simulateAspect(bool simulateAspect) => this(simulateAspect: simulateAspect);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FutureSituation(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FutureSituation(...).copyWith(id: 12, name: "My name")
  /// ````
  FutureSituation call({
    Object? name = const $CopyWithPlaceholder(),
    Object? weight = const $CopyWithPlaceholder(),
    Object? treatmentActivitiyPreferences = const $CopyWithPlaceholder(),
    Object? simulateAspect = const $CopyWithPlaceholder(),
  }) {
    return FutureSituation(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      weight: weight == const $CopyWithPlaceholder() || weight == null
          ? _value.weight
          // ignore: cast_nullable_to_non_nullable
          : weight as Weight,
      treatmentActivitiyPreferences:
          treatmentActivitiyPreferences == const $CopyWithPlaceholder() || treatmentActivitiyPreferences == null
              ? _value.treatmentActivitiyPreferences
              // ignore: cast_nullable_to_non_nullable
              : treatmentActivitiyPreferences as List<TreatmentActivityPreference>,
      simulateAspect: simulateAspect == const $CopyWithPlaceholder() || simulateAspect == null
          ? _value.simulateAspect
          // ignore: cast_nullable_to_non_nullable
          : simulateAspect as bool,
    );
  }
}

extension $FutureSituationCopyWith on FutureSituation {
  /// Returns a callable class that can be used as follows: `instanceOfFutureSituation.copyWith(...)` or like so:`instanceOfFutureSituation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FutureSituationCWProxy get copyWith => _$FutureSituationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FutureSituation _$FutureSituationFromJson(Map<String, dynamic> json) => FutureSituation(
      name: json['name'] as String,
      weight: Weight.fromJson(json['weight'] as Map<String, dynamic>),
      treatmentActivitiyPreferences: (json['treatmentActivitiyPreferences'] as List<dynamic>)
          .map((e) => TreatmentActivityPreference.fromJson(e as Map<String, dynamic>))
          .toList(),
      simulateAspect: json['simulateAspect'] as bool? ?? false,
    );

Map<String, dynamic> _$FutureSituationToJson(FutureSituation instance) => <String, dynamic>{
      'name': instance.name,
      'weight': instance.weight,
      'treatmentActivitiyPreferences': instance.treatmentActivitiyPreferences,
      'simulateAspect': instance.simulateAspect,
    };
