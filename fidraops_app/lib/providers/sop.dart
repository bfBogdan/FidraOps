import 'package:fidraops_app/data/models/sop.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/data/repositories/sop.dart';
import 'package:fidraops_app/providers/app_state.dart';
import 'package:flutter/material.dart';

class SOPProvider with ChangeNotifier {
  final SOPRepository _sopRepository = SOPRepository();

  bool _isLoading = false;
  List<SOP> _sops = [];
  String? _error;

  bool get isLoading => _isLoading;
  List<SOP> get sops => _sops;
  String? get error => _error;

  Future<void> fetchSOPs(
    HttpService httpService,
    AppState appState,
    int projectId,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _sops = await _sopRepository.fetchSOPs(httpService, appState, projectId);
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAllSOPs(
    HttpService httpService,
    AppState appState
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _sops = await _sopRepository.fetchAllSOPs(httpService, appState);
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}
