import 'package:event_management/common/constants/app_colors.dart';
import 'package:event_management/common/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    Key? key,
    required this.controller,
    this.label,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.onFieldSubmitted,
    this.readOnly,
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final FocusNode? focusNode;
  final IconData? prefixIcon, suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final bool? readOnly;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
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
        focusNode: widget.focusNode ?? FocusNode(),
        onFieldSubmitted:
            widget.onFieldSubmitted ?? (value) => widget.focusNode?.nextFocus(),
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        // validator: widget.validator ?? (value) => null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: widget.label ?? "",
          hintStyle: AppTextStyle.textFieldLabel,
          labelStyle: AppTextStyle.textFieldLabel,
          errorMaxLines: 1,
          enabled: true,
          focusedErrorBorder: InputBorder.none,
          prefixIcon: Icon(
            widget.prefixIcon,
            size: 20,
            color: AppColors.primaryColor,
          ),
          suffixIcon: Icon(
            widget.suffixIcon,
            size: 20,
          ),
          border: InputBorder.none,
          // errorBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(
          //     color: AppColors.dangerColor,
          //   ),
          // ),
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
          //     width: 2,
          //   ),
          // ),
        ),
      ),
    );
  }
}
