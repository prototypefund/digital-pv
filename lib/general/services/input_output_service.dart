import 'dart:convert';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/logging.dart';

class InputOutputService with Logging {
  InputOutputService() : _patientDirectiveService = getIt.get();

  final PatientDirectiveService _patientDirectiveService;

  void savePatientDirectiveAsFile(BuildContext context) {
    logger.i('saving current patient directive as file');

    final String directiveAsJson = jsonEncode(_patientDirectiveService.currentPatientDirective.toJson());
    final String directiveAsBase64 = base64.encode(utf8.encode(directiveAsJson));

    if (kIsWeb) {
      AnchorElement(href: "data:application/octet-stream;charset=utf-16le;base64,$directiveAsBase64")
        ..setAttribute("download", "patient-directive.json")
        ..click();
    } else {
      logger.w('downloading patient directive not implemented outside of web clients');
    }
  }
}
