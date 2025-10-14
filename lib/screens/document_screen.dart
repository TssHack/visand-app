import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visand/config/app_theme.dart';
import 'package:visand/models/document_model.dart';
import 'package:visand/services/document_service.dart';

class DocumentScreen extends StatelessWidget {
  final DocumentModel document;
  final bool isDark;

  const DocumentScreen({
    super.key,
    required this.document,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('جزئیات سند', style: GoogleFonts.vazirmatn()),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _shareDocument(context),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteDocument(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: InteractiveViewer(
              child: Image.asset('assets/sample_document.jpg'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.picture_as_pdf),
                  label: Text('PDF', style: GoogleFonts.vazirmatn()),
                  onPressed: () => _exportToPDF(context),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.text_fields),
                  label: Text('OCR', style: GoogleFonts.vazirmatn()),
                  onPressed: () => _extractText(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _shareDocument(BuildContext context) {
    DocumentService.shareDocument();
  }

  void _deleteDocument(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('حذف سند', style: GoogleFonts.vazirmatn()),
        content: Text(
          'آیا از حذف این سند مطمئن هستید؟',
          style: GoogleFonts.vazirmatn(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('لغو', style: GoogleFonts.vazirmatn()),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('سند حذف شد', style: GoogleFonts.vazirmatn()),
                  backgroundColor: AppTheme.primaryColor,
                ),
              );
            },
            child: Text('حذف', style: GoogleFonts.vazirmatn()),
          ),
        ],
      ),
    );
  }

  void _exportToPDF(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('در حال ساخت PDF...', style: GoogleFonts.vazirmatn()),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  void _extractText(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('در حال استخراج متن...', style: GoogleFonts.vazirmatn()),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }
}
