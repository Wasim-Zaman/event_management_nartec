import 'package:event_management/constants/app_text_style.dart';
import 'package:event_management/controllers/login/login_controller.dart';
import 'package:event_management/screens/registration/member_registration_screen.dart';
import 'package:event_management/widgets/buttons/primary_button_widget.dart';
import 'package:event_management/widgets/buttons/secondary_button_widget.dart';
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

  login() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill all the fields",
      );
    } else {
      // try {
      //   final response = ApiManager.postRequest(
      //       {
      //         "email": emailController.text,
      //         "password": passwordController.text,
      //       },
      //       "${URL.baseUrl}UserLoginAuth",
      //       headers: {
      //         'Content-type': 'application/json',
      //       });

      //   response.then((value) {
      //     print("status code: ${value.statusCode}");
      //     if (value.statusCode == 200) {
      //       // Save email and password in provider
      //       context.read<MemberProfile>().setEmail(emailController.text);
      //       context.read<MemberProfile>().setPassword(passwordController.text);

      //       // Navigate to profile screen
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => const MemberProfileScreen(),
      //         ),
      //       );
      //     } else {
      //       Fluttertoast.showToast(
      //         msg: jsonDecode(value.body)["message"],
      //         backgroundColor: AppColors.dangerColor,
      //       );
      //     }
      //   });
      // } catch (error) {
      //   Fluttertoast.showToast(
      //     msg: error.toString(),
      //   );
      // }
      LoginController.login(
        context,
        emailController.text,
        passwordController.text,
      );
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
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Text(
                  "Welcome",
                  style: AppTextStyle.title,
                ),
                const Text("Let's get started"),
                const SizedBox(height: 30),
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
                const SizedBox(height: 40),
                PrimaryButtonWidget(caption: "Log in", onPressed: login),
                const SizedBox(height: 20),
                SecondaryButtonWidget(
                  caption: "Create an account",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const MemberRegistrationScreen();
                        },
                      ),
                    );
                  },
                ),
                // go to registration screen
              ],
            ),
          ),
        ),
      ),
    );
  }
}
