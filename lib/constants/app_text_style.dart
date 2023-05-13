import 'package:event_management/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static var appBarTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.appTextColorPrimary,
  );

  static var title = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.appBlackColor,
  );

  static var required = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryColor,
  );

  static var textFieldLabel = const TextStyle(fontSize: 16);
}
