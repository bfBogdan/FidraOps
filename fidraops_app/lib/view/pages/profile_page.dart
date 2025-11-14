import 'package:fidraops_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.dark_mode),
          onPressed: () {
            context.read<ThemeProvider>().toggleTheme();
          },
        )
      ),
    );
  }
}
