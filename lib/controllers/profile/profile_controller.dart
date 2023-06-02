import 'dart:convert';

import 'package:event_management/common/constants/api_manager.dart';
import 'package:event_management/common/constants/url.dart';
import 'package:event_management/models/profile/profile_model.dart';

class ProfileController {
  static Future<ProfileModel> getMember(String email, String password) async {
    ProfileModel member;
    try {
      var response = await ApiManager.getRequest(
          "${URL.baseUrl}getMembersEmail_Password/$email/$password");
      if (response.statusCode == 200) {
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

  /// update profile
  static Future<bool> updateProfile(
      ProfileModel member, String memberId) async {
    try {
      var response = await ApiManager.putRequest(
        {
          "first_name": member.firstName,
          "last_name": member.lastName,
          "barangay": member.barangay,
          "province": member.province,
          "city": member.city,
          "club_name": member.clubName,
          "club_region": member.clubRegion,
          "club_president": member.clubPresident,
          "Suffix": member.suffix,
        },
        "${URL.baseUrl}tblUpdateMembers/$memberId",
      );
      print(response.statusCode);
      print(jsonDecode(response.body));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to update member!');
      }
    } catch (error) {
      rethrow;
    }
  }
}
