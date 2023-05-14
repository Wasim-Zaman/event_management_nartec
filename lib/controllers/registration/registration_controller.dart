import 'dart:convert';

import 'package:event_management/constants/api_manager.dart';
import 'package:event_management/constants/url.dart';
import 'package:event_management/models/registration/cities.dart';
import 'package:event_management/models/registration/provinces.dart';

class RegistrationController {
  static Future<List<Cities>> getAllCities() async {
    List<Cities> cities = [];
    try {
      var response =
          await ApiManager.getRequest("${URL.baseUrl}ListOfDropDownCities");
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as Map;
        final List<dynamic> citiesList = data['recordsets'][0];
        cities = citiesList.map((city) => Cities.fromJson(city)).toList();
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (error) {
      rethrow;
    }
    return cities;
  }

  static Future<List<Provinces>> getAllProvinces() async {
    List<Provinces> provinces = [];
    try {
      var response =
          await ApiManager.getRequest("${URL.baseUrl}ListOfDropDownProvince");
      if (response.statusCode == 200) {
        var data = json.decode(response.body) as Map;
        final List<dynamic> provincesList = data['recordsets'][0];
        provinces = provincesList.map((province) {
          return Provinces.fromJson(province);
        }).toList();
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (error) {
      rethrow;
    }
    return provinces;
  }

  static Future<void> registerUser(Map<String, String> data) async {
    try {
      final body = {
        "email": data['email'],
        "password": data['password'],
        "first_name": data['first_name'],
        "last_name": data['last_name'],
        "street_address": data['street_address'],
        "barangay": data['barangay'],
        "province": data['province'],
        "city": data['city'],
        "club_name": data['club_name'],
        "club_region": data['club_region'],
        "club_president": data['club_president'],
        "national_president": data['national_president'],
        "date": data['date'],
        "pe_ID": data['pe_ID'],
        "club_secretry_name": data['club_secretry_name'],
        "club_secretry_NO": data['club_secretry_NO'],
      };
      var response = await ApiManager.postRequest(
        body,
        "${URL.baseUrl}tblPostMembers",
      );
      if (response.statusCode == 200) {
      } else {
        throw Exception('An error occurred while registering user!');
      }
    } catch (error) {
      rethrow;
    }
  }
}
