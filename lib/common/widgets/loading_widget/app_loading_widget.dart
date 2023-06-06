import 'package:event_management/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.prograssiveDots(
        color: AppColors.primaryColor,
        size: 40,
      ),
    );
  }
}
