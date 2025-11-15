import 'package:fidraops_app/data/models/user.dart';
import 'package:fidraops_app/providers/bottom_navbar_provider.dart';
import 'package:fidraops_app/providers/app_state.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/providers/theme_provider.dart';
import 'package:fidraops_app/view/pages/login_page.dart';
import 'package:fidraops_app/view/pages/main_shell.dart';
import 'package:fidraops_app/view/styles/themes.dart';
import 'package:fidraops_app/view/widgets/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AppState appState = AppState();
  appState.setAuthenticated(
    User(
      id: 1,
      name: 'admin',
      password: 'adminpass',
      email: 'admin@example.com',
      createdAt: DateTime.now(),
      organizationId: 1,
      isAdmin: true,
    ),
  );
  HttpService httpService = HttpService(appState);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => appState),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavBarProvider()),
        Provider(create: (_) => httpService),
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
        home: AuthWrapper(),
      ),
    );
  }
}
