import 'package:event_management/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppSnackbars {
  static var successSnackbar = (BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.successColor,
      ),
    );
  };

  static var errorSnackbar = (BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message.replaceAll("Exception:", "")),
        backgroundColor: AppColors.dangerColor,
      ),
    );
  };
}
