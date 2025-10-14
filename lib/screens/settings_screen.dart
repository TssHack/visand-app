import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visand/providers/theme_provider.dart';
import 'package:visand/config/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _ocrLanguage = 'فارسی';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    _isDarkMode = themeProvider.isDark;

    return Scaffold(
      appBar: AppBar(title: Text('تنظیمات', style: GoogleFonts.vazirmatn())),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: SwitchListTile(
              secondary: Icon(
                _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: AppTheme.primaryColor,
              ),
              title: Text(
                'حالت تاریک',
                style: GoogleFonts.vazirmatn(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                _isDarkMode ? 'فعال' : 'غیرفعال',
                style: GoogleFonts.vazirmatn(),
              ),
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                  themeProvider.toggleTheme();
                });
              },
              activeColor: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: Icon(Icons.translate, color: AppTheme.primaryColor),
              title: Text(
                'زبان OCR',
                style: GoogleFonts.vazirmatn(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(_ocrLanguage, style: GoogleFonts.vazirmatn()),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => _showLanguageDialog(),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: Icon(Icons.storage, color: AppTheme.primaryColor),
              title: Text(
                'مدیریت حافظه',
                style: GoogleFonts.vazirmatn(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'پاکسازی فایل‌های موقت',
                style: GoogleFonts.vazirmatn(),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => _clearCache(),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: Icon(Icons.info, color: AppTheme.primaryColor),
              title: Text(
                'درباره ویسند',
                style: GoogleFonts.vazirmatn(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('نسخه 1.0.0', style: GoogleFonts.vazirmatn()),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => _showAboutDialog(),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'انتخاب زبان OCR',
          style: GoogleFonts.vazirmatn(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: Text('فارسی', style: GoogleFonts.vazirmatn()),
              value: 'فارسی',
              groupValue: _ocrLanguage,
              onChanged: (value) {
                setState(() => _ocrLanguage = value.toString());
                Navigator.pop(context);
              },
              activeColor: AppTheme.primaryColor,
            ),
            RadioListTile(
              title: Text('انگلیسی', style: GoogleFonts.vazirmatn()),
              value: 'انگلیسی',
              groupValue: _ocrLanguage,
              onChanged: (value) {
                setState(() => _ocrLanguage = value.toString());
                Navigator.pop(context);
              },
              activeColor: AppTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  void _clearCache() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'پاکسازی حافظه',
          style: GoogleFonts.vazirmatn(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'آیا از پاکسازی فایل‌های موقت اطمینان دارید؟',
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'حافظه پاکسازی شد',
                    style: GoogleFonts.vazirmatn(),
                  ),
                  backgroundColor: AppTheme.primaryColor,
                ),
              );
            },
            child: Text('پاکسازی', style: GoogleFonts.vazirmatn()),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'ویسند',
      applicationVersion: '1.0.0',
      applicationLegalese: 'تمامی حقوق محفوظ است',
      children: [
        Text(
          'اپلیکیشن اسکنر هوشمند فارسی',
          style: GoogleFonts.vazirmatn(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          'ویژگی‌ها:',
          style: GoogleFonts.vazirmatn(fontWeight: FontWeight.bold),
        ),
        Text('- اسکن اسناد با کیفیت بالا', style: GoogleFonts.vazirmatn()),
        Text('- خواندن QR کد و بارکد', style: GoogleFonts.vazirmatn()),
        Text('- استخراج متن با OCR', style: GoogleFonts.vazirmatn()),
        Text('- ساخت PDF چند صفحه‌ای', style: GoogleFonts.vazirmatn()),
        Text('- اشتراک‌گذاری آسان اسناد', style: GoogleFonts.vazirmatn()),
      ],
    );
  }
}
