import 'package:event_management/common/constants/app_snackbar.dart';
import 'package:event_management/common/widgets/buttons/primary_button_widget.dart';
import 'package:event_management/common/widgets/otp/otp_widget.dart';
import 'package:event_management/controllers/resetPassword/reset_password_controller.dart';
import 'package:event_management/providers/profile/member_profile.dart';
import 'package:event_management/screens/forgetPassword/forget_password_screen_three.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreenTwo extends StatefulWidget {
  const ForgetPasswordScreenTwo({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreenTwo> createState() =>
      _ForgetPasswordScreenTwoState();
}

class _ForgetPasswordScreenTwoState extends State<ForgetPasswordScreenTwo> {
  String otp = '';
  String email = '';
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // get otp from previous screen
    otp = '';
    Future.delayed(Duration(seconds: 3), () {}).then((value) {
      setState(() {
        otp = ModalRoute.of(context)?.settings.arguments as String;
        controller.text = otp;
        email = context.read<MemberProfile>().email;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "Enter 4 digits code",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 50),
                  // pinput for otp
                  OtpWidget(
                      otp: otp,
                      controller: controller,
                      onCompleted: (_) {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const ForgetPasswordScreenThree(),
                          ),
                        );
                      }),
                  const SizedBox(height: 20),
                  PrimaryButtonWidget(
                      caption: ("Verify"),
                      onPressed: () async {
                        if (controller.text.isEmpty) {
                          AppSnackbar.error(context, "Please enter OTP");
                        } else if (controller.text.length < 4) {
                          AppSnackbar.error(context, "Please enter valid OTP");
                        } else if (controller.text != otp) {
                          AppSnackbar.error(context, "Please enter valid OTP");
                        } else {
                          bool isVerified =
                              await ResetPasswordController.verifyOtp(
                            email,
                            otp,
                          );
                          if (isVerified) {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const ForgetPasswordScreenThree(),
                              ),
                            );
                          }
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
