import 'package:event_management/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppSnackbar {
  static void success(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.secondaryColor,
        ),
      );

  static void error(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.dangerColor,
        ),
      );
}
