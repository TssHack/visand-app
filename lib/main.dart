import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:visand/config/app_theme.dart';
import 'package:visand/providers/theme_provider.dart';
import 'package:visand/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const VisandApp(),
    ),
  );
}

class VisandApp extends StatelessWidget {
  const VisandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'ویسند',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: const MainScreen(),
          localizationsDelegates: kIsWeb
              ? []
              : const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
          supportedLocales: kIsWeb
              ? const [Locale('en', 'US')]
              : const [Locale('fa', 'IR')],
          locale: kIsWeb ? const Locale('en', 'US') : const Locale('fa', 'IR'),
        );
      },
    );
  }
}
