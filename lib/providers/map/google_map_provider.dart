import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapProvider with ChangeNotifier {
  double _latitude = 0.0;
  double _longitude = 0.0;
  String _address = '';
  String _city = '';
  String _state = '';
  String _country = '';
  Position? _position;

  double get latitude => _latitude;
  double get longitude => _longitude;
  String get address => _address;
  String get city => _city;
  String get state => _state;
  String get country => _country;
  Position? get position => _position;

  void setLatitude(double latitude) {
    _latitude = latitude;
    notifyListeners();
  }

  void setLongitude(double longitude) {
    _longitude = longitude;
    notifyListeners();
  }

  void setAddress(String address) {
    _address = address;
    notifyListeners();
  }

  void setCity(String city) {
    _city = city;
    notifyListeners();
  }

  void setState(String state) {
    _state = state;
    notifyListeners();
  }

  void setCountry(String country) {
    _country = country;
    notifyListeners();
  }

  void setPosition(Position position) {
    _position = position;
    notifyListeners();
  }

  void reset() {
    _latitude = 0.0;
    _longitude = 0.0;
    _address = '';
    _city = '';
    _state = '';
    _country = '';
    _position = null;
    notifyListeners();
  }
}
