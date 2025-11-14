import 'package:fidraops_app/view/widgets/notification_card.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  List<Map<String, dynamic>> get notifications => [
        {
          'message': 'User has completed workflow.',
          'dateTime': DateTime.now().subtract(const Duration(hours: 1)),
        },
        {
          'message': 'User has arrived at client.',
          'dateTime': DateTime.now().subtract(const Duration(hours: 2)),
        },
        {
          'message': 'User has completed workflow.',
          'dateTime': DateTime.now().subtract(const Duration(days: 1)),
        },
        {
          'message': 'New SOP assigned to you.',
          'dateTime': DateTime.now().subtract(const Duration(days: 1, hours: 3)),
        },
        {
          'message': 'User has completed workflow.',
          'dateTime': DateTime.now().subtract(const Duration(days: 1)),
        },
        {
          'message': 'New SOP assigned to you.',
          'dateTime': DateTime.now().subtract(const Duration(days: 1, hours: 3)),
        },
        {
          'message': 'SOP created successfully.',
          'dateTime': DateTime.now().subtract(const Duration(days: 3)),
        },
        {
          'message': 'User has started workflow.',
          'dateTime': DateTime.now().subtract(const Duration(days: 5)),
        },
        {
          'message': 'User has arrived at client.',
          'dateTime': DateTime.now().subtract(const Duration(days: 7)),
        },
        {
          'message': 'SOP created successfully.',
          'dateTime': DateTime.now().subtract(const Duration(days: 3)),
        },
        {
          'message': 'User has started workflow.',
          'dateTime': DateTime.now().subtract(const Duration(days: 5)),
        },
        {
          'message': 'User has arrived at client.',
          'dateTime': DateTime.now().subtract(const Duration(days: 7)),
        },
      ];

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool isYesterday(DateTime date) {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  @override
  Widget build(BuildContext context) {
    final todayNotifications =
        notifications.where((n) => isToday(n['dateTime'])).toList();

    final yesterdayNotifications =
        notifications.where((n) => isYesterday(n['dateTime'])).toList();

    final olderNotifications = notifications
        .where((n) =>
            !isToday(n['dateTime']) && !isYesterday(n['dateTime']))
        .toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Notifications',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 20, bottom: 100),
                children: buildSections(
                  context,
                  todayNotifications,
                  yesterdayNotifications,
                  olderNotifications,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildSections(
    BuildContext context,
    List<Map<String, dynamic>> today,
    List<Map<String, dynamic>> yesterday,
    List<Map<String, dynamic>> older,
  ) {
    final List<Widget> children = [];

    if (today.isNotEmpty) {
      children.add(_sectionTitle('Today', context));
      children.addAll(_buildCards(today));
      children.add(const SizedBox(height: 20));
    }

    if (yesterday.isNotEmpty) {
      children.add(_sectionTitle('Yesterday', context));
      children.addAll(_buildCards(yesterday));
      children.add(const SizedBox(height: 20));
    }

    if (older.isNotEmpty) {
      children.add(_sectionTitle('Older', context));
      children.addAll(_buildCards(older));
      children.add(const SizedBox(height: 20));
    }

    return children;
  }

  Widget _sectionTitle(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  List<Widget> _buildCards(List<Map<String, dynamic>> list) {
    return list.map((notification) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
        child: NotificationCard(
          message: notification['message'],
          dateTime: notification['dateTime'],
        ),
      );
    }).toList();
  }
}
