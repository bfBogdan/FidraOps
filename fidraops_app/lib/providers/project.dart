import 'package:fidraops_app/data/models/project.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/data/repositories/project.dart';
import 'package:fidraops_app/providers/app_state.dart';
import 'package:flutter/material.dart';

class ProjectProvider with ChangeNotifier {
  final ProjectRepository _projectRepository = ProjectRepository();
  late final HttpService _httpService;
  late final AppState _appState;

  ProjectProvider({
    required HttpService httpService,
    required AppState appState,
  }) {
    _httpService = httpService;
    _appState = appState;
  }

  bool _isLoading = false;
  List<Project> _projects = [];
  String? _error;

  bool _isDisposed = false;

  bool get isLoading => _isLoading;
  List<Project> get projects => _projects;
  String? get error => _error;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> fetchProjects() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _projects = await _projectRepository.fetchProjects(
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

  Future<void> createProject(Project project) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newProject = await _projectRepository.createProject(
        _httpService,
        _appState,
        project.toJson(),
      );

      await fetchProjects();
    } catch (e) {
      print('Error in createProject provider: $e');
      _error = e.toString();
    } finally {
      _isLoading = false;
      if (!_isDisposed) {
        notifyListeners();
      }
    }
  }
}
