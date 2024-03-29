import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_management/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ContainerTextWidget extends StatelessWidget {
  const ContainerTextWidget({Key? key, required this.text, required this.icon})
      : super(key: key);
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(10),
          // height: context.height() / 17,
          width: context.width(),
          decoration: BoxDecoration(
            color: AppColors.appGreyColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 10),
              AutoSizeText(
                text.length > 36 ? text.substring(0, 36) + '...' : text,
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
