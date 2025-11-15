import 'package:fidraops_app/data/models/user.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  User? _currentUser;

  bool get isLoggedIn => _currentUser != null;
  bool? get isAdmin => _currentUser?.isAdmin;
  User? get currentUser => _currentUser;
  int? get organizationId => _currentUser?.organizationId;

  void setAuthenticated(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void setUnauthenticated() {
    _currentUser = null;
    notifyListeners();
  }
}
