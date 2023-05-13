import 'package:event_management/constants/app_colors.dart';
import 'package:event_management/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class DateFieldWidget extends StatefulWidget {
  const DateFieldWidget({
    Key? key,
    required this.controller,
    this.focusNode,
    this.prefixIcon,
    this.readOnly,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode? focusNode;
  final IconData? prefixIcon;
  final bool? readOnly;

  @override
  State<DateFieldWidget> createState() => _DateFieldWidgetState();
}

class _DateFieldWidgetState extends State<DateFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height() / 17,
      decoration: BoxDecoration(
        color: AppColors.appGreyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: widget.controller,
        style: AppTextStyle.textFieldLabel,
        readOnly: widget.readOnly ?? false,
        focusNode: widget.focusNode ?? FocusNode(),
        onFieldSubmitted: (value) => widget.focusNode?.nextFocus(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.prefixIcon,
            size: 28,
            color: AppColors.primaryColor,
          ),

          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(
          //     color: AppColors.primaryColor,
          //   ),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(
          //     color: AppColors.primaryColor,
          //     width: 3,
          //   ),
          // ),
          suffixIcon: IconButton(
            onPressed: () async {
              widget.controller.clear();
              // date picker
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              if (date != null) {
                widget.controller.text = DateFormat.yMMMd().format(date);
              }
            },
            icon: Icon(
              Ionicons.calendar_outline,
              size: 28,
              color: AppColors.primaryColor,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
