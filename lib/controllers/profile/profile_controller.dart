import 'dart:convert';

import 'package:event_management/constants/api_manager.dart';
import 'package:event_management/constants/url.dart';
import 'package:event_management/models/profile/profile_model.dart';

class ProfileController {
  static final ApiManager _apiManager = ApiManager();
  static Future<ProfileModel> getMember(String email, String password) async {
    ProfileModel member;
    try {
      var response = await _apiManager.getRequest(
          "${URL.baseUrl}getMembersEmail_Password/$email/$password");
      if (response != null && response.statusCode == 200) {
        var data = json.decode(response.body) as Map;
        member = ProfileModel.fromJson(data["recordsets"][0][0]);
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (error) {
      rethrow;
    }
    return member;
  }
}
