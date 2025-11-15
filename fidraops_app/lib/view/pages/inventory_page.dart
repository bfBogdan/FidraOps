import 'package:fidraops_app/data/models/inventory_item.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/providers/app_state.dart';
import 'package:fidraops_app/providers/inventory.dart';
import 'package:fidraops_app/view/widgets/item_card.dart';
import 'package:fidraops_app/view/widgets/popup_form.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InventoryProvider()
        ..fetchInventory(context.read<HttpService>(), context.read<AppState>()),
      child: Builder(
        builder: (context) {
          final inventoryProvider = context.watch<InventoryProvider>();
          final items = inventoryProvider.items;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Inventory',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => showCreateInventoryItemForm(context),
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.lightGreen,
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
                              LucideIcons.plus,
                              size: 32,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => inventoryProvider.fetchInventory(
                        context.read<HttpService>(),
                        context.read<AppState>(),
                      ),
                      child: inventoryProvider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : inventoryProvider.error != null
                          ? Center(
                              child: Text('Error: ${inventoryProvider.error}'),
                            )
                          : items.isEmpty
                          ? const Center(
                              child: Text('No inventory items found'),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.only(
                                top: 20,
                                bottom: 120,
                              ),
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final item = items[index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 20,
                                  ),
                                  child: ItemCard(
                                    item: item,
                                    color:
                                        Colors.primaries[index %
                                            Colors.primaries.length],
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showCreateInventoryItemForm(BuildContext context) {
    final nameController = TextEditingController();
    final quantityController = TextEditingController();
    final items = <DropdownMenuItem<String>>[
      DropdownMenuItem(value: 'Category 1', child: Text('Category 1')),
      DropdownMenuItem(value: 'Category 2', child: Text('Category 2')),
      DropdownMenuItem(value: 'Category 3', child: Text('Category 3')),
    ];
    String? selectedCategory;

    showDialog(
      context: context,
      builder: (_) => PopupForm(
        title: "Create Inventory Item",
        fields: [
          TextField(decoration: InputDecoration(labelText: "Item Name"), controller: nameController),
          SizedBox(height: 12),
          TextField(decoration: InputDecoration(labelText: "Quantity"), controller: quantityController, keyboardType: TextInputType.number),
          SizedBox(height: 12),
          DropdownButton(items: items, onChanged: (value) { selectedCategory = value; }, value: selectedCategory, hint: Text("Select Category")),
        ],
        onSubmit: () {
          print("Item: ${nameController.text}");
          print("Quantity: ${quantityController.text}");
        },
        formType: PopupFormType.edit,
      ),
    );
  }
}
