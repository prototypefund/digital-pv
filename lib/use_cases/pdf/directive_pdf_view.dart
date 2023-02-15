import 'package:flutter/material.dart';
import 'package:pd_app/general/services/pdf_service.dart';
import 'package:pd_app/use_cases/pdf/pdf_view_model.dart';

class DirectivePdfView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final widget = FutureBuilder<Widget>(
      future: PdfService(PdfViewModel()).displayPdf(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 900, maxWidth: 1000),
              child: Center(child: snapshot.data),
            );
          }
        }
      },
    );
    return widget;
  }
}
