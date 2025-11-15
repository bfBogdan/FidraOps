import 'package:fidraops_app/data/models/project.dart';
import 'package:fidraops_app/data/models/user.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  User? _currentUser;
  Project? _currentProject;

  bool get isLoggedIn => _currentUser != null;
  bool? get isAdmin => _currentUser?.isAdmin;
  User? get currentUser => _currentUser;
  Project? get currentProject => _currentProject;
  int? get organizationId => _currentUser?.organizationId;

  void setAuthenticated(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void setUnauthenticated() {
    _currentUser = null;
    notifyListeners();
  }

  void setCurrentProject(Project project) {
    _currentProject = project;
    notifyListeners();
  }
}
