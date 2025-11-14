import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  bool _menuOpen = false;
  late AnimationController _controller;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _anim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeInBack,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    if (_menuOpen) {
      _controller.reverse();
    } else {
      _controller.forward();
    }

    setState(() {
      _menuOpen = !_menuOpen;
    });
  }

  void _handleRadialTap(int index, VoidCallback action) {
    // 1. Run the action (ex: onTap(1))
    action();

    // 2. Close menu
    _controller.reverse();
    setState(() {
      _menuOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Height of the whole bottom area (bar + space for radial menu)
    const double totalHeight = 140.0;
    const double barPaddingBottom = 16.0;

    // Define your radial items here (like before)
    final radialItems = <RadialItem>[
      RadialItem(
        icon: LucideIcons.folderKanban,
        onTap: () => widget.onTap(1), // Projects
      ),
      RadialItem(
        icon: LucideIcons.clipboardList,
        onTap: () {}, // Inventory
      ),
      RadialItem(
        icon: LucideIcons.box,
        onTap: () => widget.onTap(2),
      ),
    ];

    return SizedBox(
      height: totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // PILL NAVBAR AT THE BOTTOM
          Positioned(
            left: 20,
            right: 20,
            bottom: barPaddingBottom,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(23.0)),
                boxShadow: const [
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
                    active: widget.currentIndex == 0,
                    onTap: () => widget.onTap(0),
                  ),
                  _NavItem(
                    icon: LucideIcons.calendarRange,
                    active: widget.currentIndex == 100,
                    onTap: () {},
                  ),

                  // CENTER + BUTTON
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _toggleMenu,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutQuad,
                      width: _menuOpen ? 56 : 44,
                      height: _menuOpen ? 56 : 44,
                      alignment: Alignment.center,
                      child: AnimatedRotation(
                        turns: _menuOpen ? 0.25 : 0.0, // 90deg
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOutQuad,
                        child: Icon(
                          LucideIcons.circlePlus,
                          color: _menuOpen
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade500,
                          size: _menuOpen ? 36 : 28,
                        ),
                      ),
                    ),
                  ),

                  _NavItem(
                    icon: LucideIcons.bell,
                    active: widget.currentIndex == 3,
                    onTap: () => widget.onTap(3),
                  ),
                  _NavItem(
                    icon: LucideIcons.circleUserRound,
                    active: widget.currentIndex == 4,
                    onTap: () => widget.onTap(4),
                  ),
                ],
              ),
            ),
          ),

          // RADIAL MENU ABOVE THE BAR (NO OVERLAY)
          Positioned(
            bottom: barPaddingBottom + 40, // ~40px above bar
            left: 0,
            right: 0,
            child: IgnorePointer(
              ignoring: !_menuOpen,
              child: AnimatedBuilder(
                animation: _anim,
                builder: (context, child) {
                  if (_anim.value == 0) return const SizedBox.shrink();

                  const double radius = 80.0;
                  final count = radialItems.length;

                  const double startAngle = 2/7 * pi;
                  const double endAngle = pi;

                  return SizedBox(
                    height: radius + 50,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: List.generate(count, (i) {
                        final t = count == 1 ? 0.5 : i * 0.6 / (count - 1);
                        final angle =
                            startAngle + (endAngle - startAngle) * t;
                        final distance = radius * _anim.value;
                        final x = i == 0 ? 1.3 : 1.2;
                        final y = [0, 2].contains(i) ? 0.7 : 0.9;

                        final offset = Offset(
                          cos(angle) * distance * -1 * x,
                          sin(angle) * distance * -1 * y,
                        );

                        return Transform.translate(
                          offset: offset,
                          child: Opacity(
                            opacity: (_anim.value.isNaN ? 0.0 : _anim.value.clamp(0.0, 1.0)),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _handleRadialTap(i, radialItems[i].onTap);
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x29000000),
                                      offset: Offset(0, 2),
                                      blurRadius: 8,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  radialItems[i].icon,
                                  size: 24,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// REUSE YOUR NavItem + RadialItem

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

class RadialItem {
  final IconData icon;
  final VoidCallback onTap;

  RadialItem({
    required this.icon,
    required this.onTap,
  });
}
