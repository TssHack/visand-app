import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:visand/providers/theme_provider.dart';
import 'package:visand/config/app_theme.dart';
import 'package:visand/screens/home_screen.dart';
import 'package:visand/screens/scan_screen.dart';
import 'package:visand/screens/qr_scanner_screen.dart';
import 'package:visand/screens/settings_screen.dart';
import 'package:visand/screens/extraction_screen.dart';
import 'package:visand/widgets/custom_glass_container.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ScanScreen(),
    const QRScannerScreen(),
    const ExtractionScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBody: true,
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) => _screens[index],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.scale,
                alignment: Alignment.bottomCenter,
                child: const ScanScreen(),
              ),
            );
          },
          backgroundColor: AppTheme.primaryColor,
          child: const Icon(Icons.camera_alt),
        ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CustomGlassContainer(
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          borderRadius: BorderRadius.circular(25),
          blur: 20,
          opacity: 0.2,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: AppTheme.primaryColor,
            unselectedItemColor: isDark ? Colors.grey : Colors.grey.shade600,
            selectedLabelStyle: GoogleFonts.vazirmatn(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: GoogleFonts.vazirmatn(fontSize: 12),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: 'خانه',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.document_scanner),
                label: 'اسکن',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.qr_code_scanner),
                label: 'QR',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.text_fields),
                label: 'استخراج',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: 'تنظیمات',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
