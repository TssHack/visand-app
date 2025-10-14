import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';

class OCRService {
  static Future<String> extractText(String imagePath) async {
    try {
      final text = await FlutterTesseractOcr.extractText(
        imagePath,
        language: 'fas+eng', // فارسی + انگلیسی
        args: {'psm': '6', 'oem': '3', 'preserve_interword_spaces': '1'},
      );
      return text;
    } catch (e) {
      throw Exception('خطا در استخراج متن: $e');
    }
  }
}
