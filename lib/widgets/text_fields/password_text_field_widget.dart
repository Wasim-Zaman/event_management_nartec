import 'package:event_management/constants/app_colors.dart';
import 'package:flutter/material.dart';

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
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final FocusNode? focusNode;
  final IconData? prefixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode ?? FocusNode(),
      style: const TextStyle(fontSize: 18),
      obscureText: obscureText,
      onFieldSubmitted: (value) =>
          widget.onFieldSubmitted ?? widget.focusNode?.nextFocus(),
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      keyboardType: widget.keyboardType ?? TextInputType.visiblePassword,
      validator: widget.validator ?? (value) => null,
      decoration: InputDecoration(
        hintText: widget.label ?? "Password",
        prefixIcon: Icon(
          widget.prefixIcon ?? Icons.lock_outline,
          color: AppColors.primaryColor,
          size: 28,
        ),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off,
              color: AppColors.primaryColor),
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.dangerColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 3,
          ),
        ),
      ),
    );
  }
}
