import 'package:fidraops_app/data/models/inventory_item.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/providers/app_state.dart';

class InventoryRepository {
  //Fetch
  Future<List<InventoryItem>> fetchInventory(
    HttpService httpService,
    AppState appState,
  ) async {
    final userId = appState.currentUser?.id;
    if (userId == null) {
      throw Exception('User is not authenticated.');
    }

    try {
      final response = await httpService.dbGet('/$userId/getInventory');

      if (response.data is! List) {
        throw FormatException(
          'API did not return a list. Received: ${response.data.runtimeType}',
        );
      }

      final List<dynamic> data = response.data;
      return data
          .map(
            (itemJson) =>
                InventoryItem.fromJson(itemJson as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      print('Error in fetchInventory: $e');
      throw Exception('Failed to load inventory.');
    }
  }

  //Add
  Future<InventoryItem> addInventoryItem(
    HttpService httpService,
    AppState appState,
    Map<String, dynamic> itemData,
  ) async {
    final userId = appState.currentUser?.id;
    if (userId == null) {
      throw Exception('User is not authenticated.');
    }

    try {
      final response = await httpService.dbPost(
        '/$userId/createInventoryProduct',
        data: itemData,
      );

      print("Raw response data (500 error): ${response.data}");
      print("Raw request data: $itemData");

      final raw = response.data;

      if (raw == null) {
        throw Exception("API returned NULL response");
      }

      if (raw is Map<String, dynamic>) {
        if (raw.containsKey('inventory_item')) {
          return InventoryItem.fromJson(raw['inventory_item']);
        }

        if (raw.containsKey('project')) {
          return InventoryItem.fromJson(raw['project']);
        }

        if (raw.containsKey('id')) {
          return InventoryItem.fromJson(raw);
        }
      }

      print("Unexpected project create response: $raw");
      throw Exception("Invalid project format");
    } catch (e) {
      print('Error in addInventoryItem: $e');
      throw Exception('Failed to add inventory item.');
    }
  }
}
