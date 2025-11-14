import 'dart:math';

import 'package:flutter/material.dart';
import  'package:lucide_icons_flutter/lucide_icons.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.all(Radius.circular(23.0)),
          boxShadow: [
            BoxShadow(
              color: Color(0x29000000),
              offset: Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavItem(
              icon: LucideIcons.house,
              active: currentIndex == 0,
              onTap: () => onTap(0),
            ),
            _NavItem(
              icon: LucideIcons.calendarRange,
              active: currentIndex == 100,
              onTap: () {},
            ),
            _ExtendableNavItem(
              icon: LucideIcons.circlePlus,
              navItems: [
                _NavItem(
                  icon: LucideIcons.folderKanban,
                  active: currentIndex == 100,
                  onTap: () {},
                ),
                _NavItem(
                  icon: LucideIcons.trafficCone,
                  active: currentIndex == 100,
                  onTap: () {},
                ),
                _NavItem(
                  icon: LucideIcons.clipboardList,
                  active: currentIndex == 100,
                  onTap: () {},
                ),
                _NavItem(
                  icon: LucideIcons.box,
                  active: currentIndex == 100,
                  onTap: () {},
                ),
              ],
            ),
            _NavItem(
              icon: LucideIcons.bell,
              active: currentIndex == 100,
              onTap: () {},
            ),
            _NavItem(
              icon: LucideIcons.circleUserRound,
              active: currentIndex == 1,
              onTap: () => onTap(1),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active
        ? Theme.of(context).colorScheme.primary
        : Colors.grey.shade500;

    return IconButton(
      icon: Icon(icon, color: color, size: 28),
      onPressed: onTap,
    );
  }
}

class _ExtendableNavItem extends StatefulWidget {
  final IconData icon;
  final List<_NavItem> navItems;

  const _ExtendableNavItem({
    required this.icon,
    required this.navItems,
  });

  @override
  State<_ExtendableNavItem> createState() => _ExtendableNavItemState();
}

class _ExtendableNavItemState extends State<_ExtendableNavItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  OverlayEntry? _overlay;
  bool active = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _overlay?.remove();
    super.dispose();
  }

  void _toggleMenu() {
    if (_overlay == null) {
      _openMenu();
    } else {
      _closeMenu();
    }
  }

  void _openMenu() {
    _overlay = _createOverlay();
    Overlay.of(context).insert(_overlay!);
    setState(() => active = true);
    _controller.forward();
  }

  void _closeMenu() {
    _controller.reverse().then((_) {
      _overlay?.remove();
      _overlay = null;

      setState(() => active = false);
    });
  }

    OverlayEntry _createOverlay() {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Tap outside to close
            GestureDetector(
              onTap: _closeMenu,
              behavior: HitTestBehavior.opaque,
            ),

            // Radial menu
            Positioned(
              left: position.dx,
              top: position.dy - 80, // position menu above bar
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: _buildRadialItems(),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildRadialItems() {
    final int count = widget.navItems.length;
    final double radius = 70;

    const double startAngle = pi;
    const double endAngle = 0;
    final double arc = -1 * (startAngle - endAngle);   // pi (180 degrees)

    return List.generate(count, (i) {
      final double angle =
          startAngle - (arc * (i / (count - 1))); // distribute evenly on arc

      return Transform.translate(
        offset: Offset(
          [0, 3].contains(i) ? 1.2 * radius * _controller.value * cos(angle) : 0.9 * radius * _controller.value * cos(angle),
          [0, 3].contains(i) ? 1.2 * radius * _controller.value * sin(angle) : 0.7 * radius * _controller.value * sin(angle),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0x29000000),
                offset: Offset(0, 2),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: widget.navItems[i]
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double size = active ? 40 : 28;

    return GestureDetector(
      onTap: _toggleMenu,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutQuad,
        width: size + 16,
        height: size + 16,
        alignment: Alignment.center,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeOutBack,
          switchOutCurve: Curves.easeInBack,
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Icon(
            widget.icon,
            key: ValueKey(active), // IMPORTANT
            color: active 
                ? Theme.of(context).colorScheme.primary 
                : Colors.grey.shade500,
            size: size,
          ),
        ),
      ),
    );
  }
}
