import 'package:fidraops_app/data/models/project.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/data/repositories/project.dart';
import 'package:fidraops_app/providers/app_state.dart';
import 'package:flutter/material.dart';

class ProjectProvider with ChangeNotifier {
  final ProjectRepository _projectRepository = ProjectRepository();

  bool _isLoading = false;
  List<Project> _projects = [];
  String? _error;

  bool get isLoading => _isLoading;
  List<Project> get projects => _projects;
  String? get error => _error;

  Future<void> fetchProjects(HttpService httpService, AppState appState) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _projects = await _projectRepository.fetchProjects(httpService, appState);
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}
