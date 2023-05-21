import 'package:event_management/common/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class TableHeaderText extends StatelessWidget {
  const TableHeaderText({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyle.tableHeader);
  }
}
