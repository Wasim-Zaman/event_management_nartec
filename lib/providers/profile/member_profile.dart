import 'package:flutter/material.dart';

class MemberProfile with ChangeNotifier {
  String _email = "";
  String _password = "";
  String _memberid = "";

  String get email => _email;
  String get password => _password;
  String get memberid => _memberid;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setMemberId(String memberid) {
    _memberid = memberid;
    notifyListeners();
  }

  void reset() {
    _email = "";
    _password = "";
    _memberid = "";
    notifyListeners();
  }
}
