import 'package:fidraops_app/providers/bottom_navbar_provider.dart';
import 'package:fidraops_app/providers/theme_provider.dart';
import 'package:fidraops_app/view/pages/login_page.dart';
import 'package:fidraops_app/view/pages/main_shell.dart';
import 'package:fidraops_app/view/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavBarProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => MaterialApp(
        title: 'FidraOps',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: context.watch<ThemeProvider>().themeMode,
        debugShowCheckedModeBanner: false,

        initialRoute: '/main',
        routes: {
          '/main': (_) => MainShell(),
          '/login': (_) => const LoginPage(),
        }
      ),
    );
  }
}