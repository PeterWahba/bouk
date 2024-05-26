import 'dart:convert';
import 'dart:developer';
import 'package:caffa/Screens/Home_store/data/QR_model.dart';
import 'package:caffa/Screens/Home_store/home_store_screen.dart';
import 'package:caffa/Shared%20preferences/shared_preferences.dart';
import 'package:caffa/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanScreen extends StatefulWidget {
  @override
  _QRScanScreenState createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> with Helpers {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRArgumentsModel qrModel = QRArgumentsModel(
    availableCups: '0',
    id: '',
    orderCups: '0',
  );

  @override
  Widget build(BuildContext context) {
    var scanArea =
        (mediaQueryWidth(context) < 400 || mediaQueryHeight(context) < 400)
            ? 250.0
            : 350.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('طلب جديد'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: scanArea),
              onPermissionSet: (ctrl, p) => onPermissionSet(context, ctrl, p),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('إمسح الرمز'),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      // Stop scanning
      controller.stopCamera();
      setState(() {
        result = scanData;
      });
      setState(() {
        Map<String, dynamic> valueMap = json.decode(result!.code as String);
        qrModel = QRArgumentsModel.fromJson(valueMap);
      });
      print(result!.code);
      if (qrModel.availableCups != '0') {
        showSnackBar(context: context, message: qrModel.orderCups!);
        //update client availableCups number
        int x =
            int.parse(qrModel.availableCups!) - int.parse(qrModel.orderCups!);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(qrModel.id.toString())
            .update({
          'availableCups': x,
        });
        //update store TotalCups number
        int y = AppSettingsPreferences().availableCups +
            int.parse(qrModel.orderCups!);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(AppSettingsPreferences().id)
            .update({
          'availableCups': y,
        });
        Get.to(HomeStoreScreen());
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }

    // String data ='{id:1, name: lorem ipsum, address: dolor set amet}';
  }
}
