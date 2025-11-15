import 'package:fidraops_app/providers/app_state.dart';
import 'package:fidraops_app/providers/theme_provider.dart';
import 'package:fidraops_app/view/widgets/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  final String? username;
  final String? position;

  const ProfilePage({super.key, this.username, this.position});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80),
          child: Column(
            spacing: 50,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueAccent,
                    ),
                    child: Icon(LucideIcons.userRound, size: 80, color: Theme.of(context).colorScheme.surface),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    username ?? 'Doe James',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                    ),
                  ),
                  Text(
                    position ?? (context.read<AppState>().isAdmin == true ? 'Manager' : 'Employee'),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [
                  Text(
                    'Organisation',
                    style: Theme.of(context).textTheme.bodySmall
                  ),
                  if (context.read<AppState>().isAdmin == true) ProfileButton(
                    icon: LucideIcons.creditCard,
                    name: 'Billing & Plans',
                    onTap:() {},
                  ),
                  if (context.read<AppState>().isAdmin == true) ProfileButton(
                    icon: LucideIcons.usersRound,
                    name: 'Users',
                    onTap:() {},
                  ),
                  if (context.read<AppState>().isAdmin == true) ProfileButton(
                    icon: LucideIcons.settings,
                    name: 'Settings',
                    onTap:() {},
                  ),
                  if (context.read<AppState>().isAdmin == false) Text(
                    'Part of a team managed by your organization admin.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [
                  Text(
                    'Personal',
                    style: Theme.of(context).textTheme.bodySmall
                  ),
                  ProfileButton(
                    icon: context.read<ThemeProvider>().themeMode == ThemeMode.dark ? LucideIcons.sun : LucideIcons.moon,
                    name: context.read<ThemeProvider>().themeMode == ThemeMode.dark ? 'Light Mode' : 'Dark Mode',
                    onTap:() => context.read<ThemeProvider>().toggleTheme(),
                  ),
                  ProfileButton(
                    icon: LucideIcons.logOut,
                    name: 'Logout',
                    color: Colors.red,
                    onTap:() => context.read<AppState>().setUnauthenticated(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
