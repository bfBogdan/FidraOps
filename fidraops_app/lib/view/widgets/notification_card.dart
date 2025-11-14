import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String message;
  final DateTime dateTime;

  const NotificationCard({super.key, required this.message, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Theme.of(context).textTheme.headlineSmall?.color,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}