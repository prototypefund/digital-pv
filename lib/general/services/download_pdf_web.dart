import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/foundation.dart';

void downloadPdf(Uint8List bytes, String filename, String path) {
  final base64 = base64Encode(bytes);
  final anchor = html.AnchorElement(href: 'data:application/octet-stream;base64,$base64')..target = 'blank';
  anchor.download = filename;
  html.document.body?.append(anchor);

  anchor.click();
  anchor.remove();
}
