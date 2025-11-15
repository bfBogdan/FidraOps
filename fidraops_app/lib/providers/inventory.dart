import 'package:fidraops_app/data/models/inventory_item.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/data/repositories/inventory.dart';
import 'package:fidraops_app/providers/app_state.dart';
import 'package:flutter/material.dart';

class InventoryProvider with ChangeNotifier {
  final InventoryRepository _inventoryRepository = InventoryRepository();
  late final HttpService _httpService;
  late final AppState _appState;

  InventoryProvider({
    required HttpService httpService,
    required AppState appState,
  }) {
    _httpService = httpService;
    _appState = appState;
  }

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

  Future<void> fetchInventory() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _items = await _inventoryRepository.fetchInventory(
        _httpService,
        _appState,
      );
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;

    if (!_isDisposed) {
      notifyListeners();
    }
  }

  Future<void> addInventoryItem(InventoryItem item) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newItem = await _inventoryRepository.addInventoryItem(
        _httpService,
        _appState,
        item.toJson(),
      );

      await fetchInventory();
    } catch (e) {
      print('Error in addInventoryItem provider: $e');
      _error = e.toString();
    } finally {
      _isLoading = false;
      if (!_isDisposed) {
        notifyListeners();
      }
    }
  }
}
