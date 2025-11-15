class InventoryItem {
  final int id;
  final String title;
  final int quantity;
  final int organisationId;
  final String? category;

  InventoryItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.organisationId,
    this.category,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      id: json['id'] as int,
      title: json['title'] as String,
      quantity: json['quantity'] as int,
      organisationId: json['organisation_id'] as int,
      category: json['category'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'quantity': quantity,
      'organisationId': organisationId,
      'category': category,
    };
  }
}
