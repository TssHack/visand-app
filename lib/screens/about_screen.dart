// lib/screens/about_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:visand/config/app_theme.dart';
import 'package:visand/widgets/glassmorphic_container.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'درباره ویسند',
            style: GoogleFonts.vazirmatn(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GlassmorphicContainer(
                width: 120,
                height: 120,
                borderRadius: BorderRadius.circular(60),
                blur: 20,
                opacity: 0.2,
                child: Icon(
                  Icons.document_scanner,
                  size: 60,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'ویسند',
                style: GoogleFonts.vazirmatn(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'نسخه 1.0.0',
                style: GoogleFonts.vazirmatn(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              GlassmorphicContainer(
                borderRadius: BorderRadius.circular(20),
                blur: 15,
                opacity: 0.1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'توضیحات',
                        style: GoogleFonts.vazirmatn(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'ویسند یک اپلیکیشن اسکنر هوشمند فارسی است که به شما امکان می‌دهد اسناد، QR کدها و بارکدها را به راحتی اسکن کنید. با استفاده از فناوری OCR می‌توانید متن را از اسناد استخراج کرده و به صورت PDF ذخیره کنید.',
                        style: GoogleFonts.vazirmatn(fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GlassmorphicContainer(
                borderRadius: BorderRadius.circular(20),
                blur: 15,
                opacity: 0.1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ویژگی‌ها',
                        style: GoogleFonts.vazirmatn(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _FeatureItem(
                        icon: Icons.document_scanner,
                        title: 'اسکن اسناد',
                        description: 'اسکن حرفه‌ای اسناد با کیفیت بالا',
                      ),
                      _FeatureItem(
                        icon: Icons.qr_code_scanner,
                        title: 'QR و بارکد',
                        description: 'خواندن انواع QR کدها و بارکدها',
                      ),
                      _FeatureItem(
                        icon: Icons.text_fields,
                        title: 'استخراج متن',
                        description: 'استخراج متن از اسناد با OCR',
                      ),
                      _FeatureItem(
                        icon: Icons.picture_as_pdf,
                        title: 'ساخت PDF',
                        description: 'ایجاد فایل‌های PDF چند صفحه‌ای',
                      ),
                      _FeatureItem(
                        icon: Icons.share,
                        title: 'اشتراک‌گذاری',
                        description: 'اشتراک‌گذاری آسان اسناد',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GlassmorphicContainer(
                borderRadius: BorderRadius.circular(20),
                blur: 15,
                opacity: 0.1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تماس با ما',
                        style: GoogleFonts.vazirmatn(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: Text('ایمیل', style: GoogleFonts.vazirmatn()),
                        subtitle: Text(
                          'support@visand.app',
                          style: GoogleFonts.vazirmatn(),
                        ),
                        onTap: () =>
                            _launchURL(context, 'mailto:support@visand.app'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.language),
                        title: Text('وب‌سایت', style: GoogleFonts.vazirmatn()),
                        subtitle: Text(
                          'www.visand.app',
                          style: GoogleFonts.vazirmatn(),
                        ),
                        onTap: () =>
                            _launchURL(context, 'https://www.visand.app'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.support_agent),
                        title: Text('پشتیبانی', style: GoogleFonts.vazirmatn()),
                        subtitle: Text(
                          '۰۲۱-۱۲۳۴۵۶۷۸۹',
                          style: GoogleFonts.vazirmatn(),
                        ),
                        onTap: () => _launchURL(context, 'tel:021123456789'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'تمامی حقوق محفوظ است © ۱۴۰۲',
                style: GoogleFonts.vazirmatn(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(BuildContext context, String url) async {
    try {
      await launch(
        url,
        customTabsOption: CustomTabsOption(
          toolbarColor: AppTheme.primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: CustomTabsSystemAnimation.slideIn(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطا در باز کردن لینک', style: GoogleFonts.vazirmatn()),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppTheme.primaryColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.vazirmatn(fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: GoogleFonts.vazirmatn(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
