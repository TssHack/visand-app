import 'package:flutter/material.dart';
import 'package:visand/screens/home_screen.dart';
import 'package:visand/screens/scan_screen.dart';
import 'package:visand/screens/qr_scanner_screen.dart';
import 'package:visand/screens/settings_screen.dart';
import 'package:visand/screens/document_screen.dart';
import 'package:visand/models/document_model.dart';

class AppRoutes {
  static final routes = {
    '/': (context) => const HomeScreen(),
    '/scan': (context) {
      final mode = ModalRoute.of(context)?.settings.arguments as String?;
      return ScanScreen(mode: mode);
    },
    '/qr': (context) => const QRScannerScreen(),
    '/settings': (context) => const SettingsScreen(),
    '/document': (context) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      return DocumentScreen(
        document: args['document'] as DocumentModel,
        isDark: args['isDark'] as bool,
      );
    },
  };
}
