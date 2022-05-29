import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get_it/get_it.dart';

mixin RootContextL10N {
  L10n get l10n => GetIt.instance.get<L10n>();
}
