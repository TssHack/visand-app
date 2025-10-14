import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visand/config/app_theme.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  MobileScannerController controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('اسکن QR کد', style: GoogleFonts.vazirmatn())),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  _showResultDialog(barcode.rawValue!);
                  break;
                }
              }
            },
          ),
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  await controller.toggleTorch();
                },
                child: Text('چراغ قوه', style: GoogleFonts.vazirmatn()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showResultDialog(String code) {
    controller.stop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('نتیجه اسکن', style: GoogleFonts.vazirmatn()),
        content: Text(code, style: GoogleFonts.vazirmatn()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.start();
            },
            child: Text('ادامه اسکن', style: GoogleFonts.vazirmatn()),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('بستن', style: GoogleFonts.vazirmatn()),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
