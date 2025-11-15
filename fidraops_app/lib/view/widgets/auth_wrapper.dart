import 'package:fidraops_app/providers/app_state.dart';
import 'package:fidraops_app/view/pages/login_page.dart';
import 'package:fidraops_app/view/pages/main_shell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    if (appState.isLoggedIn) {
      return MainShell();
    } else {
      return LoginPage();
    }
  }
}