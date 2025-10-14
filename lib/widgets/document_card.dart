import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visand/models/document_model.dart';
import 'package:visand/config/app_theme.dart';
import 'package:visand/screens/document_screen.dart';

class DocumentCard extends StatelessWidget {
  final DocumentModel document;
  final bool isDark;

  const DocumentCard({super.key, required this.document, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: AppTheme.primaryColor.withOpacity(0.2),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            document.isPDF ? Icons.picture_as_pdf : Icons.insert_drive_file,
            color: AppTheme.primaryColor,
            size: 28,
          ),
        ),
        title: Text(
          document.title,
          style: GoogleFonts.vazirmatn(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          '${document.date.year}/${document.date.month}/${document.date.day}',
          style: GoogleFonts.vazirmatn(
            fontSize: 14,
            color: isDark ? Colors.grey : Colors.grey.shade600,
          ),
        ),
        trailing: PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            color: isDark ? Colors.white : Colors.black,
          ),
          onSelected: (value) {
            switch (value) {
              case 'share':
                // اشتراک‌گذاری
                break;
              case 'export':
                // خروجی PDF
                break;
              case 'delete':
                // حذف
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'share',
              child: Row(
                children: [
                  Icon(Icons.share, color: AppTheme.primaryColor),
                  SizedBox(width: 8),
                  Text('اشتراک‌گذاری', style: GoogleFonts.vazirmatn()),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'export',
              child: Row(
                children: [
                  Icon(Icons.picture_as_pdf, color: AppTheme.primaryColor),
                  SizedBox(width: 8),
                  Text('خروجی PDF', style: GoogleFonts.vazirmatn()),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: AppTheme.errorColor),
                  SizedBox(width: 8),
                  Text('حذف', style: GoogleFonts.vazirmatn()),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/document',
            arguments: {'document': document, 'isDark': isDark},
          );
        },
      ),
    );
  }
}
