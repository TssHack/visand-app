import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class DocumentService {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> saveScannedDocument(String imagePath) async {
    final path = await _localPath;
    final file = File(
      '$path/scanned_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    await File(imagePath).copy(file.path);
    return file;
  }

  static Future<File> createPDFFromImages(List<String> imagePaths) async {
    final pdf = pw.Document();
    final path = await _localPath;

    for (final imagePath in imagePaths) {
      final image = pw.MemoryImage(File(imagePath).readAsBytesSync());
      pdf.addPage(pw.Page(build: (pw.Context context) => pw.Image(image)));
    }

    final file = File(
      '$path/document_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static Future<void> shareDocument() async {
    final path = await _localPath;
    final file = File('$path/sample.pdf');
    await Share.shareFiles([file.path], text: 'مشارکت‌گذاری سند');
  }
}
