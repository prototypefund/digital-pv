import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pd_app/general/init/get_it.dart';
import 'package:pd_app/general/model/patient_directive.dart';
import 'package:pd_app/general/services/patient_directive_service.dart';
import 'package:pd_app/logging.dart';

class InputOutputService with Logging {
  InputOutputService() : _patientDirectiveService = getIt.get();

  final PatientDirectiveService _patientDirectiveService;

  void savePatientDirectiveAsFile(BuildContext context) {
    logger.i('saving current patient directive as file');

    final String directiveAsJson = jsonEncode(_patientDirectiveService.currentPatientDirective.toJson());

    if (kIsWeb) {
      String nameComponent = "";
      final surname = _patientDirectiveService.currentPatientDirective.personalDetails.surname;
      if (surname != null && surname.isNotEmpty) {
        nameComponent = "-$surname";
      }

      final dateComponent = "-${DateTime.now().toIso8601String()}";
      final filename = "patient-directive$nameComponent$dateComponent.json";

      startFileDownload(filename, Uint8List.fromList(utf8.encode(directiveAsJson)));
    } else {
      logger.w('downloading patient directive not implemented outside of web clients');
    }
  }

  Future<void> startFileDownload(String name, Uint8List bytes) async {
    await FileSaver.instance.saveFile(name, bytes, "json", mimeType: MimeType.JSON);
  }

  Future<void> loadPatientDirectiveFromFile(BuildContext context) async {
    if (kIsWeb) {
      try {
        final FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          allowedExtensions: ['json'],
        );

        if (result != null) {
          logger.i('user chose file');
          final Uint8List bytes = result.files.first.bytes!;

          final directiveContent = utf8.decode(bytes);

          logger.d('directive content is $directiveContent');
          logger.d('decoding json file content to json map');
          final Map<String, dynamic> jsonMap = json.decode(directiveContent) as Map<String, dynamic>;

          logger.d('transferring json map into a patient directive');
          final PatientDirective loadedDirective = PatientDirective.fromJson(jsonMap);
          _patientDirectiveService.currentPatientDirective = loadedDirective;
        } else {
          // User canceled the picker
          logger.i("user canceled file picker");
        }
      } catch (error, details) {
        logger.e('error loading patient directive from file: $error', error, details);
      }
    }
  }
}
