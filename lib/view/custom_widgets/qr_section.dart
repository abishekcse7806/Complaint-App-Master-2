import 'package:e_complaint/constants/strings.dart';
import 'package:e_complaint/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:e_complaint/view/qr_scan_page.dart';

class QRSection extends StatefulWidget {
  const QRSection({Key? key, required this.onPress}) : super(key: key);

  final Function onPress;

  @override
  State<QRSection> createState() => _QRSectionState();
}

class _QRSectionState extends State<QRSection> {
  String _receivedString = '';
  String _machineID = '';
  String _qrCode = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: _qrCode == ''
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: kDisabledColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 120,
                    height: 120,
                    child: IconButton(
                      onPressed: () async {
                        _receivedString = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QRScanPage()));
                        String macID = _receivedString.split('_')[1];

                        setState(() {
                          _qrCode = _receivedString;
                          _machineID = macID;
                        });

                        widget.onPress(_receivedString, _machineID);
                      },
                      icon: const Icon(
                        Icons.qr_code_scanner_sharp,
                        size: 80,
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    TextButton(
                      child: const Text(
                        kTextScanAgain,
                        style: kLinkStyle,
                      ),
                      onPressed: () async {
                        _receivedString = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QRScanPage()));
                        String macID = _receivedString.split('_')[1];

                        setState(() {
                          _qrCode = _receivedString;
                          _machineID = macID;
                        });

                        widget.onPress(_receivedString, _machineID);
                      },
                    ),
                  ],
                ),
        ),
        _qrCode == ''
            ? const Text(
          kTextOpenQRScan,
                textAlign: kCenterAlign,
              )
            : const SizedBox(),
      ],
    );
  }
}
