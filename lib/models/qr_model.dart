class QRModel {
  final String id;
  final String content;
  final DateTime date;
  final QRType type;

  QRModel({
    required this.id,
    required this.content,
    required this.date,
    required this.type,
  });
}

enum QRType { url, text, wifi, contact, other }
