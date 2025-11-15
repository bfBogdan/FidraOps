import 'package:fidraops_app/data/models/inventory_item.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/providers/app_state.dart';

class InventoryRepository {
  Future<List<InventoryItem>> fetchInventory(
    HttpService httpService,
    AppState appState,
  ) async {
    final response = await httpService.dbGet(
      '/${appState.currentUser?.id}/getInventory',
    );
    print(response.data as List);
    return (response.data as List)
        .map(
          (itemJson) =>
              InventoryItem.fromJson(itemJson as Map<String, dynamic>),
        )
        .toList();
  }
}
