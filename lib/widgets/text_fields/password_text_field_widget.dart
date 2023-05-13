import 'package:event_management/constants/app_colors.dart';
import 'package:event_management/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  const PasswordTextFieldWidget({
    Key? key,
    required this.controller,
    this.label,
    this.focusNode,
    this.prefixIcon,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.onFieldSubmitted,
    this.readOnly,
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final FocusNode? focusNode;
  final IconData? prefixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final bool? readOnly;

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool obscureText = true;

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
        focusNode: widget.focusNode ?? FocusNode(),
        readOnly: widget.readOnly ?? false,
        style: AppTextStyle.textFieldLabel,
        obscureText: obscureText,
        onFieldSubmitted: widget.onFieldSubmitted ??
            (value) => widget.onFieldSubmitted ?? widget.focusNode?.nextFocus(),
        textInputAction: widget.textInputAction ?? TextInputAction.done,
        keyboardType: widget.keyboardType ?? TextInputType.visiblePassword,
        validator: widget.validator ?? (value) => null,
        decoration: InputDecoration(
          hintText: widget.label ?? "Password",
          hintStyle: AppTextStyle.textFieldLabel,
          labelStyle: AppTextStyle.textFieldLabel,
          prefixIcon: Icon(
            widget.prefixIcon ?? Icons.lock_outline,
            color: AppColors.primaryColor,
            size: 20,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: AppColors.primaryColor,
              size: 20,
            ),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
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
          //     width: 3,
          //   ),
          // ),
        ),
      ),
    );
  }
}
