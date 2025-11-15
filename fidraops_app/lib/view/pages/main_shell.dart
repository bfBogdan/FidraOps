import 'package:fidraops_app/providers/bottom_navbar_provider.dart';
import 'package:fidraops_app/view/pages/home_page.dart';
import 'package:fidraops_app/view/pages/inventory_page.dart';
import 'package:fidraops_app/view/pages/notifications_page.dart';
import 'package:fidraops_app/view/pages/profile_page.dart';
import 'package:fidraops_app/view/pages/projects_page.dart';
import 'package:fidraops_app/view/widgets/bottom_navbar.dart';
import 'package:fidraops_app/view/widgets/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainShell extends StatelessWidget {
  MainShell({super.key});

  final navKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<BottomNavBarProvider>();

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: nav.index,
            children: [
              TabNavigator(navigatorKey: navKeys[0], child: HomePage()),
              TabNavigator(navigatorKey: navKeys[1], child: ProjectsPage()),
              TabNavigator(navigatorKey: navKeys[2], child: InventoryPage()),
              TabNavigator(navigatorKey: navKeys[3], child: NotificationsPage()),
              TabNavigator(navigatorKey: navKeys[4], child: ProfilePage()),
            ],
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Center(
              child: BottomNavBar(
                currentIndex: nav.index,
                onTap: nav.change,
              ),
            ),
          ),
        ],
      )
    );
  }
}
