import 'dart:convert';

import 'package:event_management/constants/api_manager.dart';
import 'package:event_management/constants/url.dart';
import 'package:event_management/models/registration/cities.dart';
import 'package:event_management/models/registration/provinces.dart';

class RegistrationController {
  static final ApiManager _apiManager = ApiManager();
  static Future<List<Cities>> getAllCities() async {
    List<Cities> cities = [];
    try {
      var response =
          await _apiManager.getRequest("${URL.baseUrl}ListOfDropDownCities");
      if (response != null && response.statusCode == 200) {
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
          await _apiManager.getRequest("${URL.baseUrl}ListOfDropDownProvince");
      if (response != null && response.statusCode == 200) {
        var data = json.decode(response.body) as Map;
        final List<dynamic> provincesList = data['recordsets'][0];
        provinces = provincesList.map((province) {
          return Provinces.fromJson(province);
        }).toList();
        print("Provinces got successfully");
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (error) {
      rethrow;
    }
    return provinces;
  }
}
