import 'package:flutter/cupertino.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/services/input_output_service.dart';
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/logging.dart';

class DrawerViewModel with ChangeNotifier, Logging, RootContextL10N {
  DrawerViewModel() : _inputOutputService = getIt.get();

  final InputOutputService _inputOutputService;

  String get saveDirectiveLabel => l10n.drawerSaveDirective;

  String get loadDirectiveLabel => l10n.drawerLoadDirective;

  String get drawerTitle => l10n.drawerTitle;

  void onSaveDirectiveTapped(BuildContext context) {
    _inputOutputService.savePatientDirectiveAsFile(context);
  }

  void onLoadDirectiveTapped(BuildContext context) {
    _inputOutputService.loadPatientDirectiveFromFile(context);
  }
}
