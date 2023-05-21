import 'package:event_management/common/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class RequiredTextWidget extends StatelessWidget {
  const RequiredTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    // create a text widget with a normal text and red asterisk
    return Row(
      children: [
        Text(
          text,
          style: AppTextStyle.required,
        ),
        const Text(
          '*',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
