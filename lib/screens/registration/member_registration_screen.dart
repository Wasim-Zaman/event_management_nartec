// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:event_management/controllers/registration/registration_controller.dart';
import 'package:event_management/widgets/buttons/primary_button_widget.dart';
import 'package:event_management/widgets/dropdown/dropdown_widget.dart';
import 'package:event_management/widgets/text/required_text_widget.dart';
import 'package:event_management/widgets/text_fields/date_field_widget.dart';
import 'package:event_management/widgets/text_fields/mobile_number_text_field.dart';
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

  late TabController _tabController;

  // text fields controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
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
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.wait(
      [
        // Api calls
        RegistrationController.getAllCities().then((response) {
          setState(() {
            citiesList = response.map((city) {
              return city.citiyname.toString();
            }).toList();
            selectedCity = citiesList.first;
          });
        }),
        RegistrationController.getAllProvinces().then((response) {
          setState(() {
            provinceList = response.map((province) {
              return province.provincename.toString();
            }).toList();
            selectedProvince = provinceList.first;
          });
        }),
      ],
    ).then((_) {
      setState(() {
        screenLoaded = true;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    streetController.dispose();
    clubNameController.dispose();
    clubPresidentController.dispose();
    nationalPresidentController.dispose();
    clubSecretaryController.dispose();
    dateController.dispose();
    // nodes
    lastNameNode.dispose();
    streetNode.dispose();
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
          controller: _tabController,
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
        controller: _tabController,
        children: !screenLoaded
            ? [
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ]
            : [
                personalInformation(),
                // second screen
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
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    controller: firstNameController,
                    label: "Enter Your First Name",
                    prefixIcon: Ionicons.person_outline,
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).requestFocus(lastNameNode);
                    },
                  ),
                  const SizedBox(height: 20),
                  const RequiredTextWidget(text: "Last Name"),
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    controller: lastNameController,
                    label: "Enter Your Last Name",
                    prefixIcon: Ionicons.person_outline,
                    focusNode: lastNameNode,
                    onFieldSubmitted: (p0) {
                      FocusScope.of(context).requestFocus(streetNode);
                    },
                  ),
                  const SizedBox(height: 20),
                  const RequiredTextWidget(text: "Street Address"),
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    controller: streetController,
                    label: "Select Your Street Address",
                    prefixIcon: Ionicons.home_outline,
                    focusNode: streetNode,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 20),
                  const RequiredTextWidget(text: "Province"),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 20),
                  const RequiredTextWidget(text: "City"),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 20),
                  const RequiredTextWidget(text: "Barangay"),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 20),
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
                      _tabController.animateTo(1);
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
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    controller: clubNameController,
                    label: "Enter Your Club Name",
                  ),
                  const SizedBox(height: 20),
                  const RequiredTextWidget(text: "Club Region"),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 20),
                  const RequiredTextWidget(text: "Club President"),
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    controller: clubPresidentController,
                    label: "Enter your Club President",
                  ),
                  const SizedBox(height: 20),
                  const RequiredTextWidget(text: "National President"),
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    controller: lastNameController,
                    label: "Enter Your National President",
                    focusNode: streetNode,
                  ),
                  const SizedBox(height: 20),
                  const RequiredTextWidget(text: "Date Joined"),
                  const SizedBox(height: 10),
                  // date widget
                  DateFieldWidget(controller: dateController),
                  const SizedBox(height: 20),
                  const RequiredTextWidget(
                      text: "Do You Already Have TFOE-PE ID?"),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 20),
                  const RequiredTextWidget(text: "Club Secretary Name"),
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    controller: streetController,
                    label: "Select Your Club Secretary Name",
                  ),
                  const SizedBox(height: 20),
                  const RequiredTextWidget(
                      text: "Club Secretary Contact Number"),
                  const SizedBox(height: 10),
                  MobileNumberTextField(
                    controller: mobileNumberController,
                  ),
                  const SizedBox(height: 20),
                  PrimaryButtonWidget(
                    caption: "Submit",
                    onPressed: () {
                      // submit
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
