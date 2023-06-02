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
      final response = await ApiManager.postRequest(
        {
          "email": email,
          "password": password,
        },
        "${URL.baseUrl}UserLoginAuth",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(json.decode(response.body));
        // final responseBody = jsonDecode(response.body)["recordset"] as List;
        // if (responseBody.isEmpty) {
        //   Fluttertoast.showToast(
        //     msg: "Invalid credentials",
        //     backgroundColor: AppColors.dangerColor,
        //   );
        //   return;
        // }
        bool success = jsonDecode(response.body)["success"];
        if (success) {
          // Save email and password in provider
          context.read<MemberProfile>().setEmail(email);
          context.read<MemberProfile>().setPassword(password);
          context.read<MemberProfile>().setMemberId(
              jsonDecode(response.body)["user"][0]["memberID"].toString());

          // Navigate to profile screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MemberProfileScreen(),
            ),
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Invalid status code",
          backgroundColor: AppColors.dangerColor,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
