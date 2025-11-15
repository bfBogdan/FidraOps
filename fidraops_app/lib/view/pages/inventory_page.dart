import 'package:fidraops_app/view/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  List<Map<String, dynamic>> get items => [
        {
          'name': 'Item 1',
          'category': 'Tools',
          'quantity': 10,
          'icon': LucideIcons.hammer,
        },
        {
          'name': 'Item 2',
          'category': 'Hardware',
          'quantity': 5,
          'icon': LucideIcons.drill,
        },
        {
          'name': 'Item 3',
          'category': 'Supplies',
          'quantity': 15,
          'icon': LucideIcons.box,
        },
        {
          'name': 'Item 4',
          'category': 'Electronics',
          'quantity': 7,
        },
        {
          'name': 'Item 5',
          'category': 'Furniture',
          'quantity': 3,
        },
      ];

  @override
  Widget build(BuildContext context) {
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
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
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
              child: ListView.builder(
                padding: EdgeInsets.only(top: 20, bottom: 120),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: ItemCard(
                      name: items[index]['name'],
                      category: items[index]['category'],
                      quantity: items[index]['quantity'],
                      icon: items[index]['icon'],
                      color: Colors.primaries[index % Colors.primaries.length],
                    ),
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}