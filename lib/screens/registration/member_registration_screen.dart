// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:event_management/constants/app_colors.dart';
import 'package:event_management/controllers/registration/registration_controller.dart';
import 'package:event_management/utils/snackbars/app_snackbars.dart';
import 'package:event_management/widgets/buttons/primary_button_widget.dart';
import 'package:event_management/widgets/dropdown/dropdown_widget.dart';
import 'package:event_management/widgets/loading_widget/app_loading_widget.dart';
import 'package:event_management/widgets/text/required_text_widget.dart';
import 'package:event_management/widgets/text_fields/date_field_widget.dart';
import 'package:event_management/widgets/text_fields/mobile_number_text_field.dart';
import 'package:event_management/widgets/text_fields/password_text_field_widget.dart';
import 'package:event_management/widgets/text_fields/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MemberRegistrationScreen extends StatefulWidget {
  const MemberRegistrationScreen({super.key});

  @override
  _MemberRegistrationScreenState createState() =>
      _MemberRegistrationScreenState();
}

class _MemberRegistrationScreenState extends State<MemberRegistrationScreen>
    with SingleTickerProviderStateMixin {
  bool screenLoaded = false;

  late TabController tabController = TabController(
    length: 2,
    vsync: this,
    initialIndex: 0,
  );

  // text fields controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController streetAddressController = TextEditingController();
  final TextEditingController streetController = TextEditingController();

  final TextEditingController clubNameController = TextEditingController();
  final TextEditingController clubPresidentController = TextEditingController();
  final TextEditingController nationalPresidentController =
      TextEditingController();
  final TextEditingController clubSecretaryController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  // focus nodes
  final FocusNode lastNameNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode streetAddressNode = FocusNode();
  final FocusNode streetNode = FocusNode();
  final FocusNode clubPresidentNode = FocusNode();
  final FocusNode nationalPresidentNode = FocusNode();
  final FocusNode clubSecretaryNode = FocusNode();

  // dropdown lists
  List<String> provinceList = [
    "Aklan",
    "Albay",
  ];
  List<String> citiesList = [
    "Alang-alang",
    "Baliok",
    "Bantigue",
    "Bato",
    "Binaliw",
    "Bito-on",
  ];
  final List<String> barangayList = [
    "Alang-alang",
    "Baliok",
    "Bantigue",
    "Bato",
    "Binaliw",
    "Bito-on",
  ];

  final List<String> clubRegionsList = [
    "Alang-alang",
    "Baliok",
    "Bantigue",
    "Bato",
    "Binaliw",
    "Bito-on",
  ];

  final List<String> yesNoList = [
    'Yes',
    'No',
  ];

  // dropdown values
  String selectedProvince = "Aklan";
  String selectedCity = "Alang-alang";
  String selectedBarangay = "Alang-alang";
  String selectedClubRegion = "Alang-alang";
  String selectedYesNo = "Yes";

  @override
  void initState() {
    super.initState();
    Future.wait(
      [
        // Api calls
        RegistrationController.getAllCities().then((response) {
          Future.delayed(Duration.zero, () {
            citiesList = response.map((city) {
              return city.citiyname.toString();
            }).toList();
            selectedCity = citiesList.first;
          });
        }),
        RegistrationController.getAllProvinces().then((response) {
          Future.delayed(Duration.zero, () {
            provinceList = response.map((province) {
              return province.provincename.toString();
            }).toList();
            selectedProvince = provinceList.first;
          });
        }),
      ],
    ).then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          screenLoaded = true;
        });
      }).onError((error, stackTrace) => null);
    });
  }

  register() {
    RegistrationController.registerUser({
      "email": emailController.text,
      "password": passwordController.text,
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "street_address": streetController.text,
      "barangay": selectedBarangay,
      "province": selectedProvince,
      "city": selectedCity,
      "club_name": clubNameController.text,
      "club_region": selectedClubRegion,
      "club_president": clubPresidentController.text,
      "national_president": nationalPresidentController.text,
      "date": dateController.text,
      "pe_ID": selectedYesNo,
      "club_secretry_name": clubSecretaryController.text,
      "club_secretry_NO": mobileNumberController.text,
    }).then((_) {
      // AppToasts.successToast("Registration Successful");
      AppSnackbars.successSnackbar(context, "Registration Successful");
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      // AppToasts.errorToast(error.toString());
      AppSnackbars.errorSnackbar(
        context,
        error.toString().replaceAll("Exception:", ""),
      );
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    streetAddressController.dispose();
    clubNameController.dispose();
    clubPresidentController.dispose();
    nationalPresidentController.dispose();
    clubSecretaryController.dispose();
    dateController.dispose();
    // nodes
    lastNameNode.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    streetAddressNode.dispose();
    clubPresidentNode.dispose();
    nationalPresidentNode.dispose();
    clubSecretaryNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Registration'),
        bottom: TabBar(
          controller: tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.successColor,
          ),
          tabs: [
            Tab(
              text: 'Personal Information'.toUpperCase(),
            ),
            Tab(
              text: 'tfoe-pe details'.toUpperCase(),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: !screenLoaded
            ? [
                const AppLoadingWidget(),
                const SizedBox.shrink(),
              ]
            : [
                personalInformation(),
                toePeDetails(),
              ],
      ),
    );
  }

  SizedBox personalInformation() {
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const RequiredTextWidget(text: "First Name"),
                  const SizedBox(height: 5.0),
                  TextFieldWidget(
                    controller: firstNameController,
                    label: "Enter Your First Name",
                    prefixIcon: Ionicons.person_outline,
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).requestFocus(lastNameNode);
                    },
                  ),
                  const SizedBox(height: 10.0),
                  const RequiredTextWidget(text: "Last Name"),
                  const SizedBox(height: 5.0),
                  TextFieldWidget(
                    controller: lastNameController,
                    label: "Enter Your Last Name",
                    prefixIcon: Ionicons.person_outline,
                    focusNode: lastNameNode,
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).requestFocus(emailNode);
                    },
                  ),
                  const SizedBox(height: 10.0),
                  const RequiredTextWidget(text: "Email"),
                  const SizedBox(height: 5.0),
                  TextFieldWidget(
                    controller: emailController,
                    focusNode: emailNode,
                    prefixIcon: Ionicons.mail_outline,
                    label: "Enter Your Email",
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).requestFocus(passwordNode);
                    },
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  const RequiredTextWidget(text: "Password"),
                  const SizedBox(height: 5.0),
                  PasswordTextFieldWidget(
                    controller: passwordController,
                    prefixIcon: Ionicons.lock_closed_outline,
                    label: "Enter Your Password",
                    focusNode: passwordNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).requestFocus(streetNode);
                    },
                  ),
                  const SizedBox(height: 10.0),
                  const RequiredTextWidget(text: "Street Address"),
                  const SizedBox(height: 5.0),
                  TextFieldWidget(
                    controller: streetController,
                    focusNode: streetNode,
                    prefixIcon: Ionicons.location_outline,
                    label: "Enter Your Street Address",
                    textInputAction: TextInputAction.done,
                  ),

                  const SizedBox(height: 10.0),

                  const RequiredTextWidget(text: "Province"),
                  const SizedBox(height: 5.0),
                  // province dropdown
                  DropdownWidget(
                    stringList: provinceList,
                    selectedString: selectedProvince,
                    onChanged: (p0) {
                      setState(() {
                        selectedProvince = p0!;
                      });
                    },
                  ),
                  const SizedBox(height: 10.0),
                  const RequiredTextWidget(text: "City"),
                  const SizedBox(height: 5.0),
                  // city dropdown
                  DropdownWidget(
                    stringList: citiesList,
                    selectedString: selectedCity,
                    onChanged: (p0) {
                      setState(() {
                        selectedCity = p0!;
                      });
                    },
                  ),
                  const SizedBox(height: 10.0),
                  const RequiredTextWidget(text: "Barangay"),
                  const SizedBox(height: 5.0),
                  // barangay dropdown
                  DropdownWidget(
                    stringList: barangayList,
                    selectedString: selectedBarangay,
                    onChanged: (p0) {
                      setState(() {
                        selectedBarangay = p0!;
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  PrimaryButtonWidget(
                    caption: "Next",
                    onPressed: () {
                      if (firstNameController.text.isEmpty ||
                          lastNameController.text.isEmpty ||
                          streetController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fill all required fields"),
                          ),
                        );
                        return;
                      }
                      tabController.animateTo(1);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  SizedBox toePeDetails() {
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const RequiredTextWidget(text: "Club Name"),
                  const SizedBox(height: 5.0),
                  TextFieldWidget(
                    controller: clubNameController,
                    label: "Enter Your Club Name",
                  ),
                  const SizedBox(height: 10.0),
                  const RequiredTextWidget(text: "Club Region"),
                  const SizedBox(height: 5.0),
                  // club region dropdown
                  DropdownWidget(
                    stringList: clubRegionsList,
                    selectedString: selectedClubRegion,
                    onChanged: (p0) {
                      setState(() {
                        selectedClubRegion = p0!;
                      });
                    },
                  ),
                  const SizedBox(height: 10.0),
                  const RequiredTextWidget(text: "Club President"),
                  const SizedBox(height: 5.0),
                  TextFieldWidget(
                    controller: clubPresidentController,
                    label: "Enter your Club President",
                  ),
                  const SizedBox(height: 10.0),
                  const RequiredTextWidget(text: "National President"),
                  const SizedBox(height: 5.0),
                  TextFieldWidget(
                    controller: nationalPresidentController,
                    label: "Enter Your National President",
                    focusNode: streetAddressNode,
                  ),
                  const SizedBox(height: 10.0),
                  const RequiredTextWidget(text: "Date Joined"),
                  const SizedBox(height: 5.0),
                  // date widget
                  DateFieldWidget(controller: dateController),
                  const SizedBox(height: 10.0),
                  const RequiredTextWidget(
                      text: "Do You Already Have TFOE-PE ID?"),
                  const SizedBox(height: 5.0),
                  // yes no dropdown
                  DropdownWidget(
                    stringList: yesNoList,
                    selectedString: selectedYesNo,
                    onChanged: (p0) {
                      setState(() {
                        selectedYesNo = p0!;
                      });
                    },
                  ),
                  const SizedBox(height: 10.0),
                  const RequiredTextWidget(text: "Club Secretary Name"),
                  const SizedBox(height: 5.0),
                  TextFieldWidget(
                    controller: clubSecretaryController,
                    label: "Select Your Club Secretary Name",
                  ),
                  const SizedBox(height: 10.0),
                  const RequiredTextWidget(
                      text: "Club Secretary Contact Number"),
                  const SizedBox(height: 5.0),
                  MobileNumberTextField(
                    controller: mobileNumberController,
                  ),
                  const SizedBox(height: 10.0),
                  PrimaryButtonWidget(
                    caption: "Submit",
                    onPressed: () {
                      register();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
