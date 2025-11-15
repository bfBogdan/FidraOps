import 'package:fidraops_app/data/models/inventory_item.dart';
import 'package:fidraops_app/view/widgets/popup_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final InventoryItem item;
  final Color color;
  final IconData? icon;

  const ItemCard({
    super.key,
    required this.item,
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
                _showItemMenu(context, item);
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
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      softWrap: true,
                    ),
                    Text(
                      'Category: ${item.category == '' ? 'Uncategorized' : item.category}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'Quantity: ${item.quantity}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showItemMenu(BuildContext context, InventoryItem item) {
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
                leading: Icon(
                  Icons.edit_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text("Edit item"),
                onTap: () {
                  Navigator.pop(context);
                  showEditInventoryItemForm(context, item);
                },
              ),

              // Change Quantity
              ListTile(
                leading: Icon(
                  Icons.numbers_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text("Change quantity"),
                onTap: () {
                  Navigator.pop(context);
                  showChangeQuantityInventoryItemForm(context, item);
                },
              ),

              // Delete
              ListTile(
                leading: Icon(
                  Icons.delete_rounded,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: Text(
                  "Delete",
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                onTap: () {
                  Navigator.pop(context);
                  showDeleteInventoryItemForm(context, item);
                },
              ),

              const SizedBox(height: 100),
            ],
          ),
        );
      },
    );
  }

  void showEditInventoryItemForm(BuildContext context, InventoryItem item) {
    final nameController = TextEditingController(text: item.title);
    final quantityController = TextEditingController(text: item.quantity.toString());

    showDialog(
      context: context,
      builder: (_) => PopupForm(
        title: "Edit Inventory Item",
        fields: [
          TextField(decoration: InputDecoration(labelText: "Item Name"), controller: nameController),
          SizedBox(height: 12),
          TextField(decoration: InputDecoration(labelText: "Quantity"), controller: quantityController, keyboardType: TextInputType.number),
        ],
        onSubmit: () {
          print("Item: ${nameController.text}");
          print("Quantity: ${quantityController.text}");
        },
        formType: PopupFormType.edit,
      ),
    );
  }

  void showChangeQuantityInventoryItemForm(BuildContext context, InventoryItem item) {
    final quantityController = TextEditingController(text: item.quantity.toString());

    showDialog(
      context: context,
      builder: (_) => PopupForm(
        title: "Change Quantity",
        fields: [
          SizedBox(
            height: 150,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(initialItem: item.quantity),
              itemExtent: 40,
              onSelectedItemChanged: (int index) {
                quantityController.text = index.toString();
              },
              children: List<Widget>.generate(101, (int index) {
                return Center(
                  child: Text(
                    index.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }),
            ),
          ),
        ],
        onSubmit: () {
          print("Quantity: ${quantityController.text}");
        },
        formType: PopupFormType.edit,
      ),
    );
  }

  void showDeleteInventoryItemForm(BuildContext context, InventoryItem item) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => PopupForm(
        title: "Delete Inventory Item",
        fields: [],
        onSubmit: () {
          print("Item: ${nameController.text}");
          print("Description: ${descriptionController.text}");
        },
        formType: PopupFormType.delete,
      ),
    );
  }
}
