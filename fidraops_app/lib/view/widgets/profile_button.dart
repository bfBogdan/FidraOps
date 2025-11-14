import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final IconData icon;
  final String name;
  final Color? color;
  final VoidCallback onTap;

  const ProfileButton({super.key, required this.icon, required this.name, this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
          color: color == null ? Theme.of(context).colorScheme.surface : color == Colors.red ? Color.fromRGBO(236, 189, 189, 1) : color?.withAlpha(70),
          borderRadius: BorderRadius.circular(23),
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
          children: [
            Icon(
              icon,
              color: color,
              size: 30,
            ),
            const SizedBox(width: 25),
            Text(
              name,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}