import 'package:fidraops_app/data/models/user.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  User? _currentUser;
  int? _organizationId;

  bool get isLoggedIn => _currentUser != null;
  bool? get isAdmin => _currentUser?.isAdmin;
  User? get currentUser => _currentUser;
  int? get organizationId => _organizationId;

  void setAuthenticated(User user, int organizationId) {
    _currentUser = user;
    _organizationId = organizationId;
    notifyListeners();
  }

  void setUnauthenticated() {
    _currentUser = null;
    _organizationId = null;
    notifyListeners();
  }
}
