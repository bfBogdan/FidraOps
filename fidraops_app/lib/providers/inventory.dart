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

  bool _isDisposed = false;

  bool get isLoading => _isLoading;
  List<InventoryItem> get items => _items;
  String? get error => _error;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> fetchInventory(
    HttpService httpService,
    AppState appState,
  ) async {
    if (appState.isAdmin != true) {
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _items = await _inventoryRepository.fetchInventory(httpService, appState);
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    if (!_isDisposed) {
      notifyListeners();
    }
  }
}
