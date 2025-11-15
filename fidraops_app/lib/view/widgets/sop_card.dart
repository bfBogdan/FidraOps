import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SOPCard extends StatelessWidget {
  final Map<String, dynamic> sop;

  const SOPCard({
    super.key,
    required this.sop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                _showSOPMenu(context);
              },
              icon: Icon(
                Icons.more_vert_rounded,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),

          Column(
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
                  Text(
                    sop['title'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: true,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                spacing: 8,
                children: [
                  Icon(
                    LucideIcons.fileText,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text(
                    sop['description'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    softWrap: true,
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
                  Text(
                    '${sop['required_assignee_number']} assignees required',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    softWrap: true,
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
                  Text(
                    '${sop['time_estimation_minutes']} minutes estimated',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    softWrap: true,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSOPMenu(BuildContext context) {
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
                title: const Text("Edit SOP"),
                onTap: () {
                  Navigator.pop(context);
                  print("EDIT SOP");
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
                  print("DELETE SOP");
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