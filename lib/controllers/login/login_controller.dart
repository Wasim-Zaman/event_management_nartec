import 'dart:convert';

import 'package:event_management/common/constants/api_manager.dart';
import 'package:event_management/common/constants/app_colors.dart';
import 'package:event_management/common/constants/url.dart';
import 'package:event_management/providers/profile/member_profile.dart';
import 'package:event_management/screens/profile/member_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginController {
  static Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final response = ApiManager.postRequest(
        {
          "email": email,
          "password": password,
        },
        "${URL.baseUrl}UserLoginAuth",
      );

      response.then((value) {
        if (value.statusCode == 200) {
          // Save email and password in provider
          context.read<MemberProfile>().setEmail(email);
          context.read<MemberProfile>().setPassword(password);

          // Navigate to profile screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MemberProfileScreen(),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: jsonDecode(value.body)["message"],
            backgroundColor: AppColors.dangerColor,
          );
        }
      });
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
      );
    }
  }
}
