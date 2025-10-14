import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:visand/config/app_theme.dart';
import 'package:visand/widgets/custom_glass_container.dart';
import 'package:visand/models/document_model.dart';
import 'package:visand/services/ocr_service.dart';

class ExtractionScreen extends StatefulWidget {
  const ExtractionScreen({super.key});

  @override
  State<ExtractionScreen> createState() => _ExtractionScreenState();
}

class _ExtractionScreenState extends State<ExtractionScreen> {
  bool _isLoading = false;
  String _extractedText = '';
  List<DocumentModel> _documents = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'استخراج متن',
          style: GoogleFonts.vazirmatn(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => _showHistory(),
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => _showInfo(),
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomGlassContainer(
                height: 200,
                borderRadius: BorderRadius.circular(20),
                blur: 15,
                opacity: 0.2,
                child: Column(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: 8,
                        decoration: InputDecoration(
                          hintText:
                              'متن استخراج شده اینجا نمایش داده می‌شود...',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                          hintStyle: GoogleFonts.vazirmatn(color: Colors.grey),
                        ),
                        style: GoogleFonts.vazirmatn(fontSize: 16),
                        controller: TextEditingController(text: _extractedText),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.copy),
                            label: Text('کپی', style: GoogleFonts.vazirmatn()),
                            onPressed: _extractedText.isNotEmpty
                                ? _copyText
                                : null,
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.share),
                            label: Text(
                              'اشتراک',
                              style: GoogleFonts.vazirmatn(),
                            ),
                            onPressed: _extractedText.isNotEmpty
                                ? _shareText
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'اسناد اخیر',
                style: GoogleFonts.vazirmatn(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: _documents.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.document_scanner_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'سندی برای نمایش وجود ندارد',
                              style: GoogleFonts.vazirmatn(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : MasonryGridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        itemCount: _documents.length,
                        itemBuilder: (context, index) {
                          final document = _documents[index];
                          return CustomGlassContainer(
                            height: 150,
                            borderRadius: BorderRadius.circular(15),
                            blur: 10,
                            opacity: 0.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      document.isPDF
                                          ? Icons.picture_as_pdf
                                          : Icons.insert_drive_file,
                                      color: AppTheme.primaryColor,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        document.title,
                                        style: GoogleFonts.vazirmatn(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${document.date.year}/${document.date.month}/${document.date.day}',
                                  style: GoogleFonts.vazirmatn(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.text_fields),
                                      onPressed: () =>
                                          _extractTextFromDocument(document),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.share),
                                      onPressed: () => _shareDocument(document),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickDocument,
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _copyText() {
    Clipboard.setData(ClipboardData(text: _extractedText));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('متن کپی شد', style: GoogleFonts.vazirmatn()),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  void _shareText() {
    // پیاده‌سازی اشتراک‌گذاری متن
  }

  void _pickDocument() {
    // پیاده‌سازی انتخاب سند
  }

  void _extractTextFromDocument(DocumentModel document) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final text = await OCRService.extractText(document.path);
      setState(() {
        _extractedText = text;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'خطا در استخراج متن: ${e.toString()}',
            style: GoogleFonts.vazirmatn(),
          ),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  void _shareDocument(DocumentModel document) {
    // پیاده‌سازی اشتراک‌گذاری سند
  }

  void _showHistory() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => CustomGlassContainer(
        height: 400,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        blur: 15,
        opacity: 0.2,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'تاریخچه استخراج',
                style: GoogleFonts.vazirmatn(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(
                    'متن استخراج شده ${index + 1}',
                    style: GoogleFonts.vazirmatn(),
                  ),
                  subtitle: Text(
                    '۱۴۰۲/۰۵/۰۱ - ۱۴:۳۰',
                    style: GoogleFonts.vazirmatn(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'درباره استخراج متن',
          style: GoogleFonts.vazirmatn(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'با استفاده از این قابلیت می‌توانید متن را از اسناد اسکن شده استخراج کنید. این قابلیت از فناوری OCR (تشخیص نویسه نوری) استفاده می‌کند.',
          style: GoogleFonts.vazirmatn(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('متوجه شدم', style: GoogleFonts.vazirmatn()),
          ),
        ],
      ),
    );
  }
}
