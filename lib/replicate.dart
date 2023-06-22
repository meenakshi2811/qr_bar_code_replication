
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReplicateScreen extends StatelessWidget {
  final String? qrCodeData;
  final int replicationCount;

  ReplicateScreen({
    required this.qrCodeData,
    required this.replicationCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Replicated QR Codes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                _createPDF(context);
              },
              child: Text('Print'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: replicationCount,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: BarcodeWidget(
                      barcode: qrCodeData != null && qrCodeData!.length <= 13
                          ? Barcode.code128()
                          : Barcode.qrCode(),
                      data: qrCodeData ?? '',
                      width: 150,
                      height: 150,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _createPDF(BuildContext context) async {
    final pdf = pw.Document();

    // Calculate the number of pages needed
    final int pageCount = (replicationCount / 4).ceil();

    for (int pageIndex = 0; pageIndex < pageCount; pageIndex++) {
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            final List<pw.Widget> qrCodeWidgets = [];

            // Generate QR code widgets for the current page
            final int startIndex = pageIndex * 4;
            final int endIndex = (startIndex + 4 <= replicationCount) ? (startIndex + 4) : replicationCount;
            for (int i = startIndex; i < endIndex; i++) {
              qrCodeWidgets.add(
                pw.Container(
                  margin: pw.EdgeInsets.only(bottom: 10.0),
                  child: pw.Center(
                    child: pw.BarcodeWidget(
                      barcode: qrCodeData != null && qrCodeData!.length <= 13
                          ? pw.Barcode.code128()
                          : pw.Barcode.qrCode(),
                      data: qrCodeData ?? '',
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
              );
            }

            return pw.Center(
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: qrCodeWidgets,
              ),
            );
          },
        ),
      );
    }

    final pdfFile = await pdf.save();

    try {
      final Uint8List bytes = Uint8List.fromList(pdfFile);

      await Printing.layoutPdf(
        onLayout: (format) => bytes,
      );
    } catch (e) {
      // Handle printing error
      print(e.toString());
    }
  }



}
