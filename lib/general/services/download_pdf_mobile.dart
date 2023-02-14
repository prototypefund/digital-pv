import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';

void downloadPdf(Uint8List bytes, String filename, String path) {
  unawaited(Share.shareXFiles([XFile.fromData(bytes, mimeType: 'application/pdf', name: filename)],
      text: filename, subject: filename));

  unawaited(File(path).delete());
}
