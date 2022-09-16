import 'package:pd_app/general/utils/l10n_mixin.dart';

mixin AspectViewModel on RootContextL10N {
  String get aspectSignificanceLabel => l10n.significanceSliderLabel;

  bool get showAspectSignificanceLabel => l10n.significanceSliderLabel.isNotEmpty;

  String get aspectSignificanceHighLabel => l10n.significanceHigh;

  String get aspectsSignificanceLowLabel => l10n.significanceLow;
}
