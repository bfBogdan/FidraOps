import 'package:fidraops_app/data/models/work.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/data/repositories/work.dart';
import 'package:fidraops_app/providers/app_state.dart';
import 'package:flutter/material.dart';

class WorkProvider with ChangeNotifier {
  final WorkRepository _workRepository = WorkRepository();

  bool _isLoading = false;
  List<Work> _works = [];
  String? _error;

  // --- MODIFICARE 1: Adaugă un steag pentru a urmări starea ---
  bool _isDisposed = false;

  bool get isLoading => _isLoading;
  List<Work> get works => _works;
  String? get error => _error;

  // --- MODIFICARE 2: Suprascrie metoda dispose() ---
  @override
  void dispose() {
    _isDisposed = true; // Setează steagul când provider-ul este distrus
    super.dispose();
  }

  Future<void> fetchActiveSOPs(
    HttpService httpService,
    AppState appState,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners(); // Acesta e OK, e înainte de 'await'

    try {
      _works = await _workRepository.fetchActiveSOPs(httpService, appState);
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;

    // --- MODIFICARE 3: Verifică steagul înainte de a notifica ---
    // Verifică dacă provider-ul încă mai este "în viață"
    if (!_isDisposed) {
      notifyListeners();
    }
  }
}
