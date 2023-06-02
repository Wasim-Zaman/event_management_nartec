import 'dart:convert';

import 'package:event_management/common/constants/api_manager.dart';
import 'package:event_management/common/constants/url.dart';

class ResetPasswordController {
  static Future<String> resetPassword(String email) async {
    try {
      var response = await ApiManager.postRequest(
        {"email": email},
        "${URL.baseUrl}passwordchangeotpSend",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Fluttertoast.showToast(msg: "OTP sent successfully");
        var body = json.decode(response.body) as Map;
        return body["OTP"];
      } else {
        throw Exception("An error occurred while resetting password");
      }
    } catch (e) {
      throw Exception("An error occurred while resetting password");
    }
  }

  static Future<bool> verifyOtp(String email, String otp) async {
    try {
      var response = await ApiManager.postRequest(
        {
          "email": email,
          "OTP_NO": otp,
        },
        "${URL.baseUrl}varifyOtp",
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("An error occurred while verifying OTP");
      }
    } catch (e) {
      throw Exception("An error occurred while verifying OTP");
    }
  }

  static Future<bool> changePassword(String email, String password) async {
    try {
      var response = await ApiManager.postRequest(
        {
          "email": email,
          "password": password,
        },
        "${URL.baseUrl}changePassword",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception("An error occurred while changing password");
      }
    } catch (e) {
      throw Exception("An error occurred while changing password");
    }
  }
}
