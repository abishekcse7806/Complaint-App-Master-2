import 'package:e_complaint/constants/strings.dart';
import 'package:e_complaint/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'custom_widgets/header_text.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({Key? key}) : super(key: key);

  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late Barcode result;
  late QRViewController controller;

  bool flashON = false;

  void onCreate(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        String qrCode = result.code;
        dispose();
        Navigator.pop(context, qrCode);
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kTextQRScanTitle),
        centerTitle: true,
        backgroundColor: kMainColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const HeaderText(text: kTextScanMachineSpecificQRCode),
              const SizedBox(height: 35),
              SizedBox(
                height: 350,
                width: 300,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: onCreate,
                ),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context, '');
                    },
                    icon: const Icon(Icons.close_rounded),
                    iconSize: 30,
                    color: kRedColor,
                    splashColor: kSplashColor,
                  ),
                  IconButton(
                    onPressed: () async {
                      await controller.toggleFlash();
                      setState(() {
                        flashON = !flashON;
                      });
                    },
                    icon: flashON
                        ? const Icon(Icons.flash_off_rounded)
                        : const Icon(Icons.flash_on_rounded),
                    iconSize: 30,
                    color: flashON ? kAmberColor : kDisabledColor,
                    splashColor: kSplashColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
