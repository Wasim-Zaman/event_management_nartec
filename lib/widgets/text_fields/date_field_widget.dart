import 'package:event_management/constants/app_colors.dart';
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
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode? focusNode;
  final IconData? prefixIcon;

  @override
  State<DateFieldWidget> createState() => _DateFieldWidgetState();
}

class _DateFieldWidgetState extends State<DateFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height() / 15,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: AppColors.appGreyColor,
      ),
      alignment: Alignment.center,
      child: TextFormField(
        controller: widget.controller,
        style: const TextStyle(fontSize: 18),
        focusNode: widget.focusNode ?? FocusNode(),
        onFieldSubmitted: (value) => widget.focusNode?.nextFocus(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.prefixIcon,
            size: 28,
            color: AppColors.primaryColor,
          ),
          errorBorder: InputBorder.none,
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
