import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';
import 'package:visand/providers/theme_provider.dart';
import 'package:visand/config/app_theme.dart';
import 'package:visand/models/document_model.dart';
import 'package:visand/widgets/custom_fab.dart';
import 'package:visand/widgets/document_card.dart';
import 'package:visand/widgets/empty_state.dart';
import 'package:visand/screens/document_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDark;

    // ایجاد لیست نمونه از اسناد برای نمایش
    final List<DocumentModel> documents = List.generate(
      5,
      (index) => DocumentModel(
        id: 'doc_$index',
        title: 'سند شماره ${index + 1}',
        date: DateTime.now().subtract(Duration(days: index)),
        path: 'path_to_document_$index',
        isPDF: index % 2 == 0,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ویسند',
          style: GoogleFonts.vazirmatn(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'عملیات سریع',
                  style: GoogleFonts.vazirmatn(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _QuickActionCard(
                      title: 'اسکن سند',
                      icon: Icons.document_scanner,
                      onTap: () => Navigator.pushNamed(context, '/scan'),
                      isDark: isDark,
                    ),
                    _QuickActionCard(
                      title: 'QR/بارکد',
                      icon: Icons.qr_code_scanner,
                      onTap: () => Navigator.pushNamed(context, '/qr'),
                      isDark: isDark,
                    ),
                    _QuickActionCard(
                      title: 'متن OCR',
                      icon: Icons.text_fields,
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/scan',
                        arguments: 'ocr',
                      ),
                      isDark: isDark,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'آخرین اسناد',
                  style: GoogleFonts.vazirmatn(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: documents.isEmpty
                      ? EmptyState(
                          title: 'هنوز سندی اسکن نشده',
                          subtitle: 'برای شروع روی دکمه اسکن ضربه بزنید',
                          icon: Icons.document_scanner_outlined,
                          isDark: isDark,
                        )
                      : ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index) => OpenContainer(
                            closedBuilder: (context, action) => DocumentCard(
                              document: documents[index],
                              isDark: isDark,
                            ),
                            openBuilder: (context, action) => DocumentScreen(
                              document: documents[index],
                              isDark: isDark,
                            ),
                            transitionType: ContainerTransitionType.fadeThrough,
                            transitionDuration: const Duration(
                              milliseconds: 500,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: const CustomFAB(),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;

  const _QuickActionCard({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (context, action) => InkWell(
        onTap: action,
        borderRadius: BorderRadius.circular(16),
        child: Card(
          elevation: 4,
          shadowColor: AppTheme.primaryColor.withOpacity(0.3),
          child: SizedBox(
            width: 100,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 32, color: AppTheme.primaryColor),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.vazirmatn(
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      openBuilder: (context, action) =>
          const Scaffold(body: Center(child: Text('صفحه مورد نظر'))),
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}
