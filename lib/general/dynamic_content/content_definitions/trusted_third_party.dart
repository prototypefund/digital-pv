import 'package:json_annotation/json_annotation.dart';
import 'package:pd_app/general/dynamic_content/loading/json_serializable.dart';

part 'trusted_third_party.g.dart';

@JsonSerializable()
class TrustedThirdPartyPage with SerializableAsset {
  TrustedThirdPartyPage({required this.breadcrumbTitle});

  factory TrustedThirdPartyPage.fromJson(Map<String, dynamic> json) => _$TrustedThirdPartyPageFromJson(json);

  factory TrustedThirdPartyPage.fromCMSJson(Map<String, dynamic> attributesJson) => TrustedThirdPartyPage(
        breadcrumbTitle: attributesJson['breadcrumb_title'] as String,
      );

  final String breadcrumbTitle;

  @override
  Map<String, dynamic> toJson() => _$TrustedThirdPartyPageToJson(this);
}
