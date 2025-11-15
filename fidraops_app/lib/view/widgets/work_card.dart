import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class WorkCard extends StatelessWidget {
  final Map<String, dynamic> work;

  const WorkCard({super.key, required this.work});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
      child: Row(
        children: [
          Container(
            width: 100,
            height: 130,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              LucideIcons.map,
              size: 28,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Icon(
                      LucideIcons.workflow,
                      size: 28,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Expanded(
                      child: Text(
                        work['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  spacing: 8,
                  children: [
                    Icon(
                      LucideIcons.fileText,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Expanded(
                      child: Text(
                        work['description'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  spacing: 8,
                  children: [
                    Icon(
                      LucideIcons.usersRound,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Expanded(
                      child: Text(
                        '${work['required_assignee_number']} assignees required',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  spacing: 8,
                  children: [
                    Icon(
                      LucideIcons.timer,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Expanded(
                      child: Text(
                        '${work['time_estimation_minutes']} minutes estimated',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showWorkMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(23)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // Edit
              ListTile(
                leading: Icon(Icons.edit_rounded,
                    color: Theme.of(context).colorScheme.primary),
                title: const Text("Edit Work"),
                onTap: () {
                  Navigator.pop(context);
                  print("EDIT WORK");
                  // TODO: open your edit screen
                },
              ),

              // Delete
              ListTile(
                leading: Icon(Icons.delete_rounded,
                    color: Theme.of(context).colorScheme.error),
                title: Text(
                  "Delete",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  print("DELETE WORK");
                  // TODO: delete logic
                },
              ),
              
              const SizedBox(height: 100),
            ],
          ),
        );
      },
    );
  }
}