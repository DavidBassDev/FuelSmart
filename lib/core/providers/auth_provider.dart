import 'package:flutter/material.dart';
import 'package:fuel_smart/features/users/models/user.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  User? _user;

  String? get token => _token;
  User? get user => _user;

  bool get isLogged => token != null && _user != null;

  void login(String token, User user) {
    _token = token;
    _user = user;
    notifyListeners(); //actualizar UI con prov. change notifier
  }

  void logout() {
    _token = null;
    _user = null;
    notifyListeners();
  }
}
