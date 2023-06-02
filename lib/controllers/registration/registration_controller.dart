import 'dart:convert';

import 'package:event_management/common/constants/api_manager.dart';
import 'package:event_management/common/constants/url.dart';
import 'package:event_management/models/registration/cities.dart';
import 'package:event_management/models/registration/provinces.dart';
import 'package:http/http.dart' as http;

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

  static Future<void> registerUser(
    Map<String, dynamic> data,
  ) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${URL.baseUrl}tblPostMembers"),
      );

      request.fields['email'] = data['email'].toString();
      request.fields['password'] = data['password'].toString();
      request.fields['first_name'] = data['first_name'].toString();
      request.fields['last_name'] = data['last_name'].toString();
      request.fields['street_address'] = data['street_address'].toString();
      request.fields['barangay'] = data['barangay'].toString();
      request.fields['province'] = data['province'].toString();
      request.fields['city'] = data['city'].toString();
      request.fields['club_name'] = data['club_name'].toString();
      request.fields['club_region'] = data['club_region'].toString();
      request.fields['club_president'] = data['club_president'].toString();
      // request.fields['national_president'] =
      //     data['national_president'].toString();
      request.fields['date'] = data['date'].toString();
      request.fields['pe_ID'] = data['pe_ID'].toString();
      // request.fields['club_secretry_name'] =
      //     data['club_secretry_name'].toString();
      // request.fields['club_secretry_NO'] = data['club_secretry_NO'].toString();
      request.fields['lattitiude'] = data['lattitiude'].toString();
      request.fields['longitude'] = data['longitude'].toString();
      request.fields['Suffix'] = data['Suffix'].toString();

      // Add image file to request
      var governmentIdStream =
          http.ByteStream(data['governmentIDImage'].openRead());
      var governmentIdImageLength = await data['governmentIDImage'].length();
      var governmentImageMultipartFile = http.MultipartFile(
          'governmentIDImage', governmentIdStream, governmentIdImageLength!,
          filename: data['governmentIDImage'].path);
      request.files.add(governmentImageMultipartFile);

      var selfieWithGovernmentIdStream =
          http.ByteStream(data['selfieIDImage'].openRead());
      var selfieWithGovernmentIdImageLength =
          await data['selfieIDImage'].length();
      var selfieWithGovernmentImageMultipartFile = http.MultipartFile(
          'selfieIDImage',
          selfieWithGovernmentIdStream,
          selfieWithGovernmentIdImageLength!,
          filename: data['selfieIDImage'].path);
      request.files.add(selfieWithGovernmentImageMultipartFile);

      var response = await request.send();

      if (response.statusCode == 200) {
      } else {
        throw Exception('An error occurred while registering user!');
      }
    } catch (error) {
      rethrow;
    }
  }
}
