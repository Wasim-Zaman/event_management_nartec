import 'package:event_management/constants/api_manager.dart';
import 'package:event_management/constants/app_colors.dart';
import 'package:event_management/constants/url.dart';
import 'package:event_management/screens/profile/member_profile_screen.dart';
import 'package:event_management/screens/registration/member_registration_screen.dart';
import 'package:event_management/widgets/buttons/primary_button_widget.dart';
import 'package:event_management/widgets/text_fields/password_text_field_widget.dart';
import 'package:event_management/widgets/text_fields/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';

class MemberLoginScreen extends StatefulWidget {
  const MemberLoginScreen({super.key});

  @override
  State<MemberLoginScreen> createState() => _MemberLoginScreenState();
}

class _MemberLoginScreenState extends State<MemberLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPressed = false;

  login() {
    isPressed = true;
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill all the fields",
      );
      isPressed = false;
    } else {
      Fluttertoast.showToast(
        msg: "Please wait...",
      );
      final response = ApiManager().postRequest(
        {
          "email": emailController.text,
          "password": passwordController.text,
        },
        "${URL.baseUrl}UserLoginAuth",
      );

      response.then((value) {
        if (value.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const MemberProfileScreen();
              },
              fullscreenDialog: true,
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: "Invalid credentials",
            backgroundColor: AppColors.dangerColor,
          );
        }
      });

      isPressed = false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Login'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFieldWidget(
                controller: emailController,
                prefixIcon: Ionicons.mail_outline,
                label: "Email",
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              PasswordTextFieldWidget(
                controller: passwordController,
                prefixIcon: Ionicons.lock_closed_outline,
                label: "Password",
              ),
              const SizedBox(height: 20),
              // go to registration screen
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const MemberRegistrationScreen();
                      },
                    ),
                  );
                },
                child: const Text(
                  "Don't have an account? Register",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PrimaryButtonWidget(caption: "Log in", onPressed: login),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}