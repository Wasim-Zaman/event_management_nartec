import 'package:event_management/common/constants/app_snackbar.dart';
import 'package:event_management/common/widgets/buttons/secondary_button_widget.dart';
import 'package:event_management/common/widgets/text/heading_text_widget.dart';
import 'package:event_management/common/widgets/text_fields/password_text_field_widget.dart';
import 'package:event_management/controllers/resetPassword/reset_password_controller.dart';
import 'package:event_management/providers/profile/member_profile.dart';
import 'package:event_management/screens/login/member_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreenThree extends StatefulWidget {
  const ForgetPasswordScreenThree({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreenThree> createState() =>
      _ForgetPasswordScreenThreeState();
}

class _ForgetPasswordScreenThreeState extends State<ForgetPasswordScreenThree> {
  String email = '';
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // get email from previous screen
    email = '';
    Future.delayed(Duration(seconds: 1), () {}).then((value) {
      setState(() {
        email = context.read<MemberProfile>().email;
      });
    });
    super.initState();
  }

  verifyOtp(BuildContext context) async {
    if (passwordController.text.isEmpty) {
      AppSnackbar.error(context, "Please enter password");
      return;
    }
    try {
      bool isChanged = await ResetPasswordController.changePassword(
        email,
        passwordController.text,
      );
      if (isChanged) {
        AppSnackbar.success(context, "Password changed successfully");
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            PageTransition(
              child: MemberLoginScreen(),
              type: PageTransitionType.fade,
            ),
          );
        });
      } else {
        AppSnackbar.error(context, "Something went wrong");
      }
    } catch (e) {
      AppSnackbar.error(context, e.toString());
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter new password",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Set a new password for your account so you can login and access all features.",
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 50),
                  // password input
                  HeadingTextWidget(text: "Set Password"),
                  PasswordTextFieldWidget(
                    controller: passwordController,
                    prefixIcon: Ionicons.lock_closed,
                  ),
                  const SizedBox(height: 20),
                  // reset password button
                  SecondaryButtonWidget(
                    caption: "Reset Password",
                    onPressed: () async {
                      await verifyOtp(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
