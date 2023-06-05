import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class ReplicateScreen extends StatelessWidget {
  final String qrCodeData;
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
      body: ListView.builder(
        itemCount: replicationCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0), // Set the desired vertical spacing
            child: ListTile(
              title: BarcodeWidget(
                barcode: Barcode.qrCode(),
                data: qrCodeData,
                width: 150,
                height: 150,
              ),
            ),
          );
        },
      ),
    );
  }
}
