import 'package:event_management/common/widgets/buttons/primary_button_widget.dart';
import 'package:event_management/common/widgets/text/heading_text_widget.dart';
import 'package:event_management/common/widgets/text_fields/text_field_widget.dart';
import 'package:event_management/controllers/resetPassword/reset_password_controller.dart';
import 'package:event_management/providers/profile/member_profile.dart';
import 'package:event_management/screens/forgetPassword/forget_password_screen_two.dart';
import 'package:event_management/utils/snackbars/app_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreenOne extends StatefulWidget {
  const ForgetPasswordScreenOne({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreenOne> createState() =>
      _ForgetPasswordScreenOneState();
}

class _ForgetPasswordScreenOneState extends State<ForgetPasswordScreenOne> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
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
                    'Enter your email address and we will send you a link to reset your password',
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 50),
                  HeadingTextWidget(text: "Email"),
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    controller: emailController,
                    label: "john@example.com",
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Ionicons.mail_open,
                  ),
                  const SizedBox(height: 20),
                  PrimaryButtonWidget(
                    caption: "Continue",
                    onPressed: () async {
                      if (emailController.text.isEmpty) {
                        AppSnackbars.errorSnackbar(
                          context,
                          'Please enter email address',
                        );
                      } else {
                        Provider.of<MemberProfile>(context, listen: false)
                            .setEmail(emailController.text);
                        var otp = await ResetPasswordController.resetPassword(
                          emailController.text.trim(),
                        );

                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const ForgetPasswordScreenTwo(),
                            settings: RouteSettings(
                              arguments: otp,
                            ),
                          ),
                        );
                      }
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
