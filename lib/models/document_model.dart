// lib/models/document_model.dart
class DocumentModel {
  final String id;
  final String title;
  final DateTime date;
  final String path;
  final String? extractedText;
  final bool isPDF;

  DocumentModel({
    required this.id,
    required this.title,
    required this.date,
    required this.path,
    this.extractedText,
    this.isPDF = false,
  });
}
