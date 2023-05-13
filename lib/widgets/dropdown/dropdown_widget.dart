import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_management/constants/app_colors.dart';
import 'package:event_management/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class DropdownWidget extends StatefulWidget {
  final List<String> stringList;
  final String selectedString;
  final Function(String?)? onChanged;

  const DropdownWidget({
    Key? key,
    required this.stringList,
    required this.selectedString,
    this.onChanged,
  }) : super(key: key);

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      height: context.height() / 17,
      padding: const EdgeInsets.only(left: 50, right: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: AppColors.appGreyColor,
        // color: AppColors.appGreyColor,
      ),
      child: DropdownButton<String>(
        value: widget.selectedString,
        icon: Icon(
          Ionicons.chevron_down,
          color: AppColors.primaryColor,
        ),
        isExpanded: true,
        underline: Container(),
        items: widget.stringList.isEmpty
            ? []
            : widget.stringList.map((String string) {
                return DropdownMenuItem<String>(
                  value: string,
                  child: Text(string, style: AppTextStyle.textFieldLabel),
                );
              }).toList(),
        onChanged: widget.onChanged ?? (_) {},
      ),
    );
  }
}
