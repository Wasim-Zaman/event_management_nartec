import 'package:flutter/material.dart';

class MemberProfile with ChangeNotifier {
  String _email = "";
  String _password = "";

  String get email => _email;
  String get password => _password;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void reset() {
    _email = "";
    _password = "";
    notifyListeners();
  }
}
