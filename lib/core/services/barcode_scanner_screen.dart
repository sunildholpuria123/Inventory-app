import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String barcode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barcode Scanner')),

      body: Column(
        children: [
          Expanded(
            flex: 4,

            child: MobileScanner(
              onDetect: (capture) {
                final codes = capture.barcodes;

                if (codes.isNotEmpty) {
                  setState(() {
                    barcode = codes.first.rawValue ?? '';
                  });
                }
              },
            ),
          ),

          Expanded(
            child: Center(
              child: Text(
                barcode.isEmpty ? 'Scan barcode' : barcode,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
