import 'package:country_code_picker/country_code_picker.dart';
import 'package:event_management/constants/app_colors.dart';
import 'package:event_management/constants/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class MobileNumberTextField extends StatefulWidget {
  const MobileNumberTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<MobileNumberTextField> createState() => _MobileNumberTextFieldState();
}

class _MobileNumberTextFieldState extends State<MobileNumberTextField> {
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
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Enter Mobile Number",
          border: InputBorder.none,
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
          prefixIcon: CountryCodePicker(
            initialSelection: 'SA',
            showCountryOnly: true,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            showOnlyCountryWhenClosed: true,
            alignLeft: false,
            hideMainText: true,
            onInit: (value) {
              widget.controller.text = value!.dialCode.toString();
            },
            onChanged: (value) {
              widget.controller.text = value.dialCode.toString();
            },
          ),
        ),
      ),
    );
  }
}
