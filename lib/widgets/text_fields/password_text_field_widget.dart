import 'package:event_management/constants/app_colors.dart';
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
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final FocusNode? focusNode;
  final IconData? prefixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool obscureText = true;

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
        // focusNode: widget.focusNode ?? FocusNode(),
        style: const TextStyle(fontSize: 18),
        obscureText: obscureText,
        //onFieldSubmitted: (value) => widget.focusNode?.nextFocus(),
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
          border: InputBorder.none,
        ),
      ),
    );
  }
}
