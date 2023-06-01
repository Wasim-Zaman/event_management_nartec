// ignore_for_file: use_build_context_synchronously

import 'package:event_management/common/constants/app_snackbar.dart';
import 'package:event_management/common/widgets/buttons/primary_button_widget.dart';
import 'package:event_management/common/widgets/text/required_text_widget.dart';
import 'package:event_management/common/widgets/text_fields/text_field_widget.dart';
import 'package:event_management/controllers/HelpDesk/help_desk_controller.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CreateHelpDeskScreen extends StatefulWidget {
  const CreateHelpDeskScreen({Key? key}) : super(key: key);

  @override
  State<CreateHelpDeskScreen> createState() => _CreateHelpDeskScreenState();
}

class _CreateHelpDeskScreenState extends State<CreateHelpDeskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _issuesController = TextEditingController();
  final _additionalDetailsController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _issuesController.dispose();
    _additionalDetailsController.dispose();

    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Help Desk"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox.expand(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const RequiredTextWidget(
                    text: "First Name",
                  ),
                  const SizedBox(height: 5),
                  TextFieldWidget(
                    controller: _firstNameController,
                    prefixIcon: Ionicons.person_outline,
                    label: "Enter first name",
                  ),
                  const SizedBox(height: 10),
                  const RequiredTextWidget(
                    text: "Last Name",
                  ),
                  const SizedBox(height: 5),
                  TextFieldWidget(
                    controller: _lastNameController,
                    prefixIcon: Ionicons.person_outline,
                    label: "Enter last name",
                  ),
                  const SizedBox(height: 10),
                  const RequiredTextWidget(
                    text: "Email",
                  ),
                  const SizedBox(height: 5),
                  TextFieldWidget(
                    controller: _emailController,
                    prefixIcon: Ionicons.mail_outline,
                    label: "Enter email",
                  ),
                  const SizedBox(height: 10),
                  const RequiredTextWidget(
                    text: "Whats's the issue?",
                  ),
                  const SizedBox(height: 5),
                  TextFieldWidget(
                    controller: _issuesController,
                    prefixIcon: Ionicons.help_outline,
                    label: "Enter issue",
                  ),
                  const SizedBox(height: 10),
                  const RequiredTextWidget(
                    text: "Additional Details",
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _additionalDetailsController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Enter additional details",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  PrimaryButtonWidget(caption: "Save", onPressed: saveForm),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  saveForm() async {
    if (_firstNameController.text.trim().isNotEmpty &&
        _lastNameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _issuesController.text.trim().isNotEmpty &&
        _additionalDetailsController.text.trim().isNotEmpty) {
      try {
        var isPosted = await HelpDeskController.postHelpDesk(
          {
            "first_name": _firstNameController.text.trim(),
            "last_name": _lastNameController.text.trim(),
            "email": _emailController.text.trim(),
            "issue": _issuesController.text.trim(),
            "detail": _additionalDetailsController.text.trim(),
          },
        );

        if (isPosted) {
          AppSnackbar.success(context, "Help desk posted successfully");
          // clear all the fields
          _firstNameController.clear();
          _lastNameController.clear();
          _emailController.clear();
          _issuesController.clear();
          _additionalDetailsController.clear();

          // focus on first name field
          FocusScope.of(context).requestFocus(FocusNode());

          // pop the screen
          Navigator.pop(context);
        } else {
          AppSnackbar.error(context, "Failed to post help desk");
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll("Exception:", "")),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all the required fields"),
        ),
      );
    }
  }
}
