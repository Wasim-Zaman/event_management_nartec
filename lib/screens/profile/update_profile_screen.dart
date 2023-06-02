import 'package:event_management/common/widgets/buttons/primary_button_widget.dart';
import 'package:event_management/common/widgets/dropdown/dropdown_widget.dart';
import 'package:event_management/common/widgets/text/heading_text_widget.dart';
import 'package:event_management/common/widgets/text_fields/text_field_widget.dart';
import 'package:event_management/controllers/profile/profile_controller.dart';
import 'package:event_management/models/profile/profile_model.dart';
import 'package:event_management/providers/profile/member_profile.dart';
import 'package:event_management/utils/snackbars/app_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class UpdateMemberScreen extends StatefulWidget {
  const UpdateMemberScreen({Key? key}) : super(key: key);

  @override
  State<UpdateMemberScreen> createState() => _UpdateMemberScreenState();
}

class _UpdateMemberScreenState extends State<UpdateMemberScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController barangayController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController clubNameController = TextEditingController();
  final TextEditingController clubRegionController = TextEditingController();
  final TextEditingController clubPresidentController = TextEditingController();
  final TextEditingController suffixController = TextEditingController();

  String memberId = "";
  String selectedSuffix = "Mr";
  String email = '', password = '';
  ProfileModel? profileModel;
  final List<String> suffixList = [
    'Mr',
    'Mrs',
    'Miss',
    'Jr',
    'Sr',
    'Dr',
    'Engr',
    'Atty',
    'Hon',
    '1st',
    '2nd',
    '3rd',
  ];

  @override
  void initState() {
    Future.delayed(Duration.zero, () {}).then((_) {
      setState(() {
        memberId = context.read<MemberProfile>().memberid;
      });
      email = context.read<MemberProfile>().email;
      password = context.read<MemberProfile>().password;
      ProfileController.getMember(email, password).then((model) {
        setState(() {
          profileModel = model;
          firstNameController.text = profileModel!.firstName!;
          lastNameController.text = profileModel!.lastName!;
          barangayController.text = profileModel!.barangay!;
          cityController.text = profileModel!.city!;
          provinceController.text = profileModel!.province!;
          clubNameController.text = profileModel!.clubName!;
          clubRegionController.text = profileModel!.clubRegion!;
          clubPresidentController.text = profileModel!.clubPresident!;
          suffixController.text = profileModel!.suffix!;
          selectedSuffix = profileModel!.suffix!;
        });
      }).onError((error, stackTrace) {});
    });
    super.initState();
  }

  updateMember() async {
    try {
      bool isUpdated = await ProfileController.updateProfile(
        ProfileModel(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          barangay: barangayController.text,
          city: cityController.text,
          province: provinceController.text,
          clubName: clubNameController.text,
          clubRegion: clubRegionController.text,
          clubPresident: clubPresidentController.text,
          suffix: selectedSuffix,
        ),
        memberId,
      );
      if (isUpdated) {
        AppSnackbars.successSnackbar(
          context,
          'Profile updated successfully',
        );
        Navigator.pop(context);
      } else {
        AppSnackbars.errorSnackbar(
          context,
          'Something went wrong',
        );
      }
    } catch (e) {
      AppSnackbars.errorSnackbar(
        context,
        'Something went wrong',
      );
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    barangayController.dispose();
    cityController.dispose();
    provinceController.dispose();
    clubNameController.dispose();
    clubRegionController.dispose();
    clubPresidentController.dispose();
    suffixController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Profile')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingTextWidget(text: "Suffix"),
                  DropdownWidget(
                    stringList: suffixList,
                    selectedString: selectedSuffix,
                    onChanged: (value) {
                      setState(() {
                        selectedSuffix = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  HeadingTextWidget(text: "First Name"),
                  TextFieldWidget(
                    controller: firstNameController,
                    prefixIcon: Ionicons.person_outline,
                  ),
                  const SizedBox(height: 10),
                  HeadingTextWidget(text: "Last Name"),
                  TextFieldWidget(
                    controller: lastNameController,
                    prefixIcon: Ionicons.person_outline,
                  ),
                  const SizedBox(height: 10),
                  HeadingTextWidget(text: "Barangay"),
                  TextFieldWidget(
                    controller: barangayController,
                    prefixIcon: Ionicons.location_outline,
                  ),
                  const SizedBox(height: 10),
                  HeadingTextWidget(text: "City"),
                  TextFieldWidget(
                    controller: cityController,
                    prefixIcon: Ionicons.location_outline,
                  ),
                  const SizedBox(height: 10),
                  HeadingTextWidget(text: "Province"),
                  TextFieldWidget(
                    controller: provinceController,
                    prefixIcon: Ionicons.location_outline,
                  ),
                  const SizedBox(height: 10),
                  HeadingTextWidget(text: "Club Name"),
                  TextFieldWidget(
                    controller: clubNameController,
                    prefixIcon: Ionicons.person_outline,
                  ),
                  const SizedBox(height: 10),
                  HeadingTextWidget(text: "Club Region"),
                  TextFieldWidget(
                    controller: clubRegionController,
                    prefixIcon: Ionicons.recording_outline,
                  ),
                  const SizedBox(height: 10),
                  HeadingTextWidget(text: "Club President"),
                  TextFieldWidget(
                    controller: clubPresidentController,
                    prefixIcon: Ionicons.person_outline,
                  ),
                  const SizedBox(height: 10),
                  PrimaryButtonWidget(
                      caption: "Update",
                      onPressed: () async {
                        await updateMember();
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
