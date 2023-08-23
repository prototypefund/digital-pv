import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pd_app/general/services/download_pdf_mobile.dart'
    if (dart.library.html) 'package:pd_app/general/services/download_pdf_web.dart' as downloader;
import 'package:pd_app/general/utils/l10n_mixin.dart';
import 'package:pd_app/use_cases/pdf/pdf_view_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfx/pdfx.dart' as pdfx;
import 'package:printing/printing.dart';

class PdfService with RootContextL10N {
  PdfService(PdfViewModel pdfViewModel) : _pdfViewModel = pdfViewModel;
  final PdfViewModel _pdfViewModel;

  Future<void> downloadPdf() async {
    final bytes = generatePdf();
    final filename = generateFilename(_pdfViewModel.patientName);
    final path = kIsWeb == false ? await _generateFilePath(filename) : '';
    if (!kIsWeb) {
      await _createFile(bytes, path);
    }
    downloader.downloadPdf(await bytes, filename, path);
  }

  pw.Widget header(pw.Context pdfContext, pw.ImageProvider icon) =>
      pw.Center(child: pw.Container(alignment: pw.Alignment.topCenter, width: 50, height: 50, child: pw.Image(icon)));

  pw.Widget footer(pw.Context pdfContext) {
    return pw.Column(
      children: [
        pw.TableHelper.fromTextArray(context: pdfContext, tableWidth: pw.TableWidth.max, data: <List<String>>[
          <String>['', ''],
          <String>[_pdfViewModel.footerPlaceAndDate, _pdfViewModel.footerSignature],
        ]),
        pw.SizedBox(height: 20),
        pw.Footer(
          leading: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [pw.Text(_pdfViewModel.directiveOf), pw.Text(_pdfViewModel.createdAt)]),
          title: pw.Text(_pdfViewModel.pageNumberOfTotalPages(
              pageNumber: pdfContext.pageNumber, pagesCount: pdfContext.pagesCount)),
          trailing: pw.BarcodeWidget(
            width: 40,
            height: 40,
            color: PdfColors.black,
            barcode: pw.Barcode.qrCode(),
            data: _pdfViewModel.qrCodeData,
          ),
        ),
      ],
    );
  }

  Future<Uint8List> generatePdf() async {
    final pw.Document pdf = pw.Document();
    final icon = await imageFromAssetBundle('assets/images/icon.png');
    final profilePicture = await _pdfViewModel.profilePicture;

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(30),
        header: (pw.Context pdfContext) {
          return header(pdfContext, icon);
        },
        footer: (pw.Context pdfContext) {
          return footer(pdfContext);
        },
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Center(child: pw.Text(_pdfViewModel.headerTitle, style: pw.Theme.of(context).header0)),
            pw.SizedBox(height: 20),
            pw.Paragraph(text: _pdfViewModel.introductionParagraph),
            pw.Container(
                child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Image(profilePicture, height: 100, width: 150),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 20),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Align(
                          alignment: pw.Alignment.topLeft,
                          child: pw.Text(_pdfViewModel.directiveOf, style: pw.Theme.of(context).header1)),
                      pw.SizedBox(height: 10),
                      pw.Align(
                          alignment: pw.Alignment.topLeft,
                          child: pw.Text(_pdfViewModel.createdAt, style: pw.Theme.of(context).header3)),
                      pw.Align(
                          alignment: pw.Alignment.topLeft,
                          child: pw.Text(_pdfViewModel.personsOfTrust, style: pw.Theme.of(context).header5)),
                    ],
                  ),
                ),
              ],
            )),
            pw.SizedBox(height: 40),
            pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Text(_pdfViewModel.treatmentGoal, style: pw.Theme.of(context).header1)),
            pw.SizedBox(height: 20),
            pw.Paragraph(text: _pdfViewModel.paragraphTreatmentTarget),
            pw.Container(
              decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('AFDFFF'),
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
                  border: pw.Border.all(
                    color: PdfColor.fromHex('004470'),
                    width: 0.5,
                  )),
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(20),
                child: pw.Column(
                  children: [
                    pw.Align(
                        child: pw.Text(_pdfViewModel.paragraphPrincipleWishTitle, style: pw.Theme.of(context).header1),
                        alignment: pw.Alignment.topLeft),
                    pw.SizedBox(height: 20),
                    // TODO(marius): add treatment preferences
                  ],
                ),
              ),
            )
          ];
        }));

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(30),
        header: (pw.Context pdfContext) {
          return header(pdfContext, icon);
        },
        footer: (pw.Context pdfContext) {
          return footer(pdfContext);
        },
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.SizedBox(height: 40),
            pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Text(_pdfViewModel.paragraphSpecificMeasuresTitle, style: pw.Theme.of(context).header1)),
            pw.SizedBox(height: 20),
            pw.Paragraph(text: _pdfViewModel.paragraphSpecificMeasures),
            pw.SizedBox(height: 40),
            pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Text(_pdfViewModel.paragraphValidityTitle, style: pw.Theme.of(context).header1)),
            pw.SizedBox(height: 20),
            pw.Paragraph(text: _pdfViewModel.paragraphValidity),
            pw.SizedBox(height: 40),
            pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Text(_pdfViewModel.paragraphReleaseSecrecyTitle, style: pw.Theme.of(context).header1)),
            pw.SizedBox(height: 20),
            pw.Paragraph(text: _pdfViewModel.paragraphReleaseSecrecy),
            pw.SizedBox(height: 40),
            pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Text(_pdfViewModel.representativesTitle, style: pw.Theme.of(context).header1)),
            pw.SizedBox(height: 20),
            pw.Paragraph(text: _pdfViewModel.representatives),
            pw.SizedBox(height: 40),
            pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Text(_pdfViewModel.paragraphEnclosedExplanationTitle, style: pw.Theme.of(context).header1)),
            pw.SizedBox(height: 20),
            pw.Paragraph(text: _pdfViewModel.paragraphEnclosedExplanation),
            pw.SizedBox(height: 40),
            pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Text(_pdfViewModel.pdfParagraphConclusionTitle, style: pw.Theme.of(context).header1)),
            pw.SizedBox(height: 20),
            pw.Paragraph(text: _pdfViewModel.pdfParagraphConclusion),
            pw.SizedBox(height: 40),
            pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Text(_pdfViewModel.pdfParagraphAdviceTitle, style: pw.Theme.of(context).header1)),
            pw.SizedBox(height: 20),
            pw.Paragraph(text: _pdfViewModel.pdfParagraphAdvice),
          ];
        }));

    return pdf.save();
  }

  Future<Widget> displayPdf() async {
    final bytes = generatePdf();
    Future<pdfx.PdfDocument> document;
    if (kIsWeb) {
      document = pdfx.PdfDocument.openData(bytes);
    } else {
      final filePath = await _generateFilePath(_pdfViewModel.patientName);
      await _createFile(bytes, filePath);
      document = pdfx.PdfDocument.openFile(filePath);
    }
    final pdfController = pdfx.PdfControllerPinch(document: document);
    return pdfx.PdfViewPinch(
      controller: pdfController,
    );
  }

  Future<String> _generateFilePath(String name) async {
    final directory = await getTemporaryDirectory();
    final fileName = generateFilename(name);
    return p.join(directory.path, fileName);
  }

  String generateFilename(String name) {
    final now = DateTime.now();
    final formatter = DateFormat('dd-MM-yyyy');
    final formattedDate = formatter.format(now);
    final fileName = 'dPV-$formattedDate-$name.pdf';
    return fileName;
  }

  Future<void> _createFile(Future<Uint8List> bytes, String filePath) async {
    final file = File(filePath);
    await file.writeAsBytes(await bytes);
  }
}
