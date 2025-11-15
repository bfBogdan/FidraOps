import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/providers/app_state.dart';
import 'package:fidraops_app/providers/inventory.dart';
import 'package:fidraops_app/view/widgets/item_card.dart';
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
                          onTap: () {},
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
                                    id: item.id,
                                    title: item.title,
                                    category: item.category,
                                    quantity: item.quantity,
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
}
