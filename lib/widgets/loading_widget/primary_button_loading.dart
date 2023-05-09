import 'package:event_management/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PrimaryButtonLoading extends StatelessWidget {
  const PrimaryButtonLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.discreteCircle(
        color: AppColors.backgroundColor!,
        secondRingColor: AppColors.appWhiteColor,
        thirdRingColor: AppColors.successColor,
        size: 25,
      ),
    );
  }
}
