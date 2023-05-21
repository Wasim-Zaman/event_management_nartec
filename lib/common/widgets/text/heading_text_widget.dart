import 'package:event_management/common/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class HeadingTextWidget extends StatelessWidget {
  const HeadingTextWidget({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        text,
        style: AppTextStyle.required,
      ),
    );
  }
}
