import 'package:event_management/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpWidget extends StatefulWidget {
  const OtpWidget({
    Key? key,
    required this.otp,
    required this.controller,
    required this.onCompleted,
  }) : super(key: key);
  final String otp;
  final TextEditingController controller;
  final Function(String) onCompleted;

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
      fontSize: 20,
      color: AppColors.secondaryColor,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.primaryColor, width: 2),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Pinput(
      defaultPinTheme: defaultPinTheme,
      length: 4,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // style

      keyboardType: TextInputType.number,
      controller: widget.controller,
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
      pinAnimationType: PinAnimationType.slide,
      validator: (s) {
        if (s!.length < 4) {
          return 'Please enter valid OTP';
        }
        widget.otp == s ? null : 'Please enter valid OTP';
        return null;
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: widget.onCompleted,
    );
  }
}
