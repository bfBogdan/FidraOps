import 'package:fidraops_app/providers/bottom_navbar_provider.dart';
import 'package:fidraops_app/view/pages/home_page.dart';
import 'package:fidraops_app/view/pages/notifications_page.dart';
import 'package:fidraops_app/view/pages/profile_page.dart';
import 'package:fidraops_app/view/pages/projects_page.dart';
import 'package:fidraops_app/view/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  final List<Widget> pages = const [
    HomePage(),
    ProjectsPage(),
    NotificationsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<BottomNavBarProvider>();

    return Scaffold(
      body: Stack(
        children: [
          // Main content
          pages[nav.index],

          // Floating navbar
          Positioned(
            left: 0,
            right: 0,
            bottom: 20, // Distance from bottom
            child: Center(
              child: BottomNavBar(
                currentIndex: nav.index,
                onTap: nav.change,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
