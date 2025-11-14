import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final String category;
  final int quantity;
  final Color color;
  final IconData? icon;

  const ItemCard({
    super.key,
    required this.name,
    required this.category,
    required this.quantity,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                _showItemMenu(context);
              },
              icon: Icon(
                Icons.more_vert_rounded,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Icon(
                    icon ?? Icons.question_mark_rounded,
                    size: 30,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  )
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    'Category: $category',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    'Quantity: $quantity',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showItemMenu(BuildContext context) {
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
                title: const Text("Edit item"),
                onTap: () {
                  Navigator.pop(context);
                  print("EDIT ITEM");
                  // TODO: open your edit screen
                },
              ),

              // Change Quantity
              ListTile(
                leading: Icon(Icons.numbers_rounded,
                    color: Theme.of(context).colorScheme.primary),
                title: const Text("Change quantity"),
                onTap: () {
                  Navigator.pop(context);
                  print("CHANGE QUANTITY");
                  // TODO: open change quantity dialog
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
                  print("DELETE ITEM");
                  // TODO: delete logic
                },
              ),
            ],
          ),
        );
      },
    );
  }
}