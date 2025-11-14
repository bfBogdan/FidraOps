import 'package:fidraops_app/providers/bottom_navbar_provider.dart';
import 'package:fidraops_app/view/pages/home_page.dart';
import 'package:fidraops_app/view/pages/profile_page.dart';
import 'package:fidraops_app/view/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  final List<Widget> pages = const [
    HomePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<BottomNavBarProvider>();

    return Scaffold(
      body: pages[nav.index],
      bottomNavigationBar: BottomNavBar(
        currentIndex: nav.index,
        onTap: nav.change,
      ),
    );
  }
}
