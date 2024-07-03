import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class QRScanPage extends StatefulWidget {
  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  final HomeController homeController = Get.find<HomeController>();

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController qrcontroller) {
    this.controller = qrcontroller;
    qrcontroller.scannedDataStream.listen((scanData) {
      // Parsing the scan result
      // String qrCodeData = scanData.code!;
      // Map<String, dynamic> parsedData = jsonDecode(qrCodeData);
      // String uniqueId = parsedData['unique_id'];
      // Post the extracted unique_id
      this.controller?.pauseCamera();
      homeController.handleScanResult(scanData.code!);
      print(
        "hasil qr ${scanData.code!}",
      );
      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 300,
        ),
      ),
    );
  }
}
