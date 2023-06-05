import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:qr_code/replicate.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  String? _qrInfo = 'Scan a QR/Bar code';
  bool camState = false;
  int replicationCount = 1; // Default replication count is set to 1


  qrCallback(String? code) {
    setState(() {
      camState = false;
      _qrInfo = code;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      camState = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (camState == true) {

            setState(() {

              camState = false;
            });
          } else {
            setState(() {
              camState = true;
            });
          }
        },
        child: const Icon(Icons.camera),
      ),
      body: camState
          ? Center(
        child: SizedBox(
          height: 1000,
          width: 500,
          child: QRBarScannerCamera(
            onError: (context, error) => Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            qrCodeCallback: (code) {
              qrCallback(code);
            },
          ),
        ),
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all()),

              child:Text(
                "Code :${_qrInfo!}",
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
              ),
              child: _qrInfo != null && _qrInfo!.isNotEmpty
                  ?BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: _qrInfo!,
                  width: 200,
                  height: 200
              )
                  : const Text(
                "Scan a QR/Bar code",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Replicate QR Code',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  replicationCount = int.tryParse(value) ?? 1;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReplicateScreen(
                          qrCodeData: _qrInfo ?? '',
                          replicationCount: replicationCount,
                        ),
                      )
                  );
                });
              },
            ),
          ],
        ),
      ),

    );
  }
}
