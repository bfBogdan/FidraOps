import 'package:fidraops_app/data/models/inventory_item.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/data/repositories/inventory.dart';
import 'package:fidraops_app/providers/app_state.dart';
import 'package:flutter/material.dart';

class InventoryProvider with ChangeNotifier {
  final InventoryRepository _inventoryRepository = InventoryRepository();

  bool _isLoading = false;
  List<InventoryItem> _items = [];
  String? _error;

  bool get isLoading => _isLoading;
  List<InventoryItem> get items => _items;
  String? get error => _error;

  Future<void> fetchInventory(
    HttpService httpService,
    AppState appState,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _items = await _inventoryRepository.fetchInventory(httpService, appState);
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}
