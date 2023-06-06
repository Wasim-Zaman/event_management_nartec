// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, deprecated_member_use

import 'dart:io';

import 'package:event_management/common/constants/app_colors.dart';
import 'package:event_management/common/services/image_picker/app_image_picker.dart';
import 'package:event_management/common/widgets/buttons/primary_button_widget.dart';
import 'package:event_management/common/widgets/buttons/secondary_button_widget.dart';
import 'package:event_management/common/widgets/dropdown/dropdown_widget.dart';
import 'package:event_management/common/widgets/loading_widget/app_loading_widget.dart';
import 'package:event_management/common/widgets/text/container_text_widget.dart';
import 'package:event_management/common/widgets/text/required_text_widget.dart';
import 'package:event_management/common/widgets/text_fields/date_field_widget.dart';
import 'package:event_management/common/widgets/text_fields/password_text_field_widget.dart';
import 'package:event_management/common/widgets/text_fields/text_field_widget.dart';
import 'package:event_management/controllers/location/location_controller.dart';
import 'package:event_management/controllers/profile/profile_controller.dart';
import 'package:event_management/controllers/registration/registration_controller.dart';
import 'package:event_management/models/profile/profile_model.dart';
import 'package:event_management/providers/profile/member_profile.dart';
import 'package:event_management/screens/map/google_map_screen.dart';
import 'package:event_management/screens/profile/member_profile_screen.dart';
import 'package:event_management/screens/registration/widgets/image/circular_image_widget.dart';
import 'package:event_management/screens/registration/widgets/image/un_selected_image_widget.dart';
import 'package:event_management/utils/snackbars/app_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen>
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
  final TextEditingController latLongController = TextEditingController();
  final TextEditingController streetController = TextEditingController();

  final TextEditingController clubNameController = TextEditingController();
  final TextEditingController clubPresidentController = TextEditingController();
  final TextEditingController nationalPresidentController =
      TextEditingController();
  final TextEditingController clubSecretaryController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController clubRegionController = TextEditingController();

  // focus nodes
  final FocusNode lastNameNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode streetAddressNode = FocusNode();
  final FocusNode streetNode = FocusNode();
  final FocusNode clubPresidentNode = FocusNode();
  final FocusNode nationalPresidentNode = FocusNode();
  final FocusNode clubSecretaryNode = FocusNode();

  // files
  File? governmentIdFile;
  File? selfieWithGovernmentIdFile;

  // dropdown lists
  List<String> provinceList = [];
  List<String> citiesList = [
    "Alang-alang",
    "Baliok",
    "Bantigue",
    "Bato",
    "Binaliw",
    "Bito-on",
  ];
  List<String> barangayList = [];

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

  final List<String> yesNoList = [
    'Yes',
    'No',
  ];

  // dropdown values
  String selectedProvince = "";
  String selectedCity = "Alang-alang";
  String selectedBarangay = "";
  String selectedYesNo = "Yes";
  String selectedSuffix = "Mr";

  // ids
  int selectedProvinceId = 0;

  // Other variables
  double lat = 0;
  double lng = 0;
  String address = "";
  String memberId = "";
  String email = "";
  String password = "";
  ProfileModel? profileModel;

  String governmentIdString = "";
  String selfieWithGovernmentIdString = "";

  Set<Marker> markers = {};

  Future<File> urlToFile(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    final fileName = imageUrl.split('/').last;
    final directory = await getTemporaryDirectory();
    final imageFile = File('${directory.path}/$fileName');
    await imageFile.writeAsBytes(bytes);
    return imageFile;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {}).then((_) {
      memberId = context.read<MemberProfile>().memberid;
      email = context.read<MemberProfile>().email;
      password = context.read<MemberProfile>().password;
      getMemberProfile();
    });

    Future.delayed(Duration.zero, () {}).then((_) {
      setState(() {
        screenLoaded = true;
      });
    });

    tabController.addListener(() {
      setState(() {});
    });
  }

  getMemberProfile() {
    ProfileController.getMember(email, password).then((model) {
      profileModel = model;
      firstNameController.text = profileModel!.firstName!;
      lastNameController.text = profileModel!.lastName!;
      // selectedBarangay = profileModel!.barangay!;
      selectedCity = profileModel!.city!;
      // selectedProvince = profileModel!.province!;
      clubNameController.text = profileModel!.clubName!;
      clubRegionController.text = profileModel!.clubRegion!;
      clubPresidentController.text = profileModel!.clubPresident!;
      selectedSuffix = profileModel!.suffix!;
      email = profileModel!.email!;
      password = profileModel!.password!;
      emailController.text = profileModel!.email!;
      passwordController.text = profileModel!.password!;
      dateController.text = profileModel!.date!;
      streetAddressController.text = profileModel!.streetAddress!;
      streetController.text = profileModel!.streetAddress!;
      lat = double.parse(profileModel!.lattitiude!);
      lng = double.parse(profileModel!.longitude!);
      address = profileModel!.streetAddress!;
      latLongController.text = profileModel!.lattitiude! +
          ", " +
          profileModel!.longitude! +
          " (" +
          profileModel!.streetAddress! +
          ")";

      // select selfie and government id path
      urlToFile(profileModel!.governmentIDImage!).then((file) {
        setState(() {
          governmentIdFile = file;
        });
      });
      urlToFile(profileModel!.selfieIDImage!).then((file) {
        setState(() {
          selfieWithGovernmentIdFile = file;
        });
      });

      markers.add(
        Marker(
          markerId: MarkerId("1"),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: address,
          ),
        ),
      );
    }).onError((error, stackTrace) {});
  }

  updateMember() {
    RegistrationController.updateMember({
      "email": emailController.text,
      "password": passwordController.text,
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "street_address": streetController.text.isEmpty
          ? streetAddressController.text
          : streetController.text,
      "barangay": selectedBarangay,
      "province": selectedProvince,
      "city": selectedCity,
      "club_name": clubNameController.text,
      "club_region": clubRegionController.text,
      "club_president": clubPresidentController.text,
      // "national_president": nationalPresidentController.text,
      "date": dateController.text,
      "pe_ID": selectedYesNo,
      // "club_secretry_name": clubSecretaryController.text,
      // "club_secretry_NO": mobileNumberController.text,
      "lattitiude": lat.toString(),
      "longitude": lng.toString(),
      "governmentIDImage": governmentIdFile,
      "selfieIDImage": selfieWithGovernmentIdFile,
      "Suffix": selectedSuffix,
    }, memberId)
        .then((_) {
      // AppToasts.successToast("Registration Successful");
      AppSnackbars.successSnackbar(context, "Member's profile updated");
      Navigator.pushReplacement(
        context,
        PageTransition(
            child: MemberProfileScreen(),
            type: PageTransitionType.rightToLeftWithFade),
      );
    }).onError((error, stackTrace) {
      // AppToasts.errorToast(error.toString());
      AppSnackbars.errorSnackbar(
        context,
        error.toString().replaceAll("Exception:", ""),
      );
    });
  }

  void launchGoogleMaps() async {
    const url =
        'https://www.google.com/maps/search/?api=1&query=current+location';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch Google Maps';
    }
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
        title: const Text('Update Profile'),
        bottom: TabBar(
          controller: tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.secondaryColor,
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
                  const RequiredTextWidget(text: "Suffix"),
                  const SizedBox(height: 5.0),
                  DropdownWidget(
                    stringList: suffixList,
                    selectedString: selectedSuffix,
                    onChanged: (value) {
                      setState(() {
                        selectedSuffix = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 10.0),
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
                  const RequiredTextWidget(text: "City"),
                  const SizedBox(height: 5.0),
                  FutureBuilder(
                    future: RegistrationController.getAllCities(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        citiesList = snapshot.data!
                            .map((e) => e.citiyname!)
                            .toSet()
                            .toList();
                        selectedProvinceId = snapshot.data!
                            .firstWhere(
                                (element) => element.citiyname == selectedCity)
                            .provanceID!;
                        return DropdownWidget(
                          stringList: citiesList,
                          selectedString: selectedCity,
                          onChanged: (city) {
                            setState(() {
                              selectedCity = city!;
                              selectedProvinceId = snapshot.data!
                                  .firstWhere((element) =>
                                      element.citiyname == selectedCity)
                                  .provanceID!;
                              print(selectedProvinceId);
                            });
                          },
                        );
                      } else {
                        return const AppLoadingWidget();
                      }
                    },
                  ),
                  const SizedBox(height: 10.0),
                  const RequiredTextWidget(text: "Province"),
                  const SizedBox(height: 5.0),
                  FutureBuilder(
                    future: RegistrationController.getAllProvinces(
                      selectedProvinceId,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const AppLoadingWidget();
                      }
                      if (snapshot.hasError) {
                        return const AppLoadingWidget();
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        provinceList = snapshot.data!
                            .map((e) => e.provincename!)
                            .toSet()
                            .toList();
                        return DropdownWidget(
                          stringList: provinceList,
                          selectedString: selectedProvince == ""
                              ? provinceList.first
                              : selectedProvince,
                          onChanged: (p0) {
                            setState(() {
                              selectedProvince = p0!;
                            });
                          },
                        );
                      }
                      return const AppLoadingWidget();
                    },
                  ).visible(selectedProvinceId != 0),
                  const SizedBox(height: 10.0),
                  const RequiredTextWidget(text: "Barangay"),
                  const SizedBox(height: 5.0),
                  FutureBuilder(
                    future: RegistrationController.getAllBarangay(
                      selectedProvinceId,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const AppLoadingWidget();
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        barangayList = snapshot.data!
                            .map((e) => e.barangayName!)
                            .toSet()
                            .toList();
                        return DropdownWidget(
                          stringList: barangayList,
                          selectedString: selectedBarangay == ""
                              ? barangayList.first
                              : selectedBarangay,
                          onChanged: (p0) {
                            setState(() {
                              selectedBarangay = p0!;
                            });
                          },
                        );
                      }
                      return const AppLoadingWidget();
                    },
                  ).visible(selectedProvinceId != 0),
                  const SizedBox(height: 10.0),
                  // const SizedBox(height: 10.0),
                  // const RequiredTextWidget(text: "Province"),
                  // const SizedBox(height: 5.0),
                  // // province dropdown
                  // DropdownWidget(
                  //   stringList: provinceList,
                  //   selectedString: selectedProvince,
                  //   onChanged: (p0) {
                  //     setState(() {
                  //       selectedProvince = p0!;
                  //     });
                  //   },
                  // ),
                  // const SizedBox(height: 10.0),
                  // const RequiredTextWidget(text: "City"),
                  // const SizedBox(height: 5.0),
                  // // city dropdown
                  // DropdownWidget(
                  //   stringList: citiesList,
                  //   selectedString: selectedCity,
                  //   onChanged: (p0) {
                  //     setState(() {
                  //       selectedCity = p0!;
                  //     });
                  //   },
                  // ),
                  // const SizedBox(height: 10.0),
                  // const RequiredTextWidget(text: "Barangay"),
                  // const SizedBox(height: 5.0),
                  // // barangay dropdown
                  // DropdownWidget(
                  //   stringList: barangayList,
                  //   selectedString: selectedBarangay,
                  //   onChanged: (p0) {
                  //     setState(() {
                  //       selectedBarangay = p0!;
                  //     });
                  //   },
                  // ),
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
                  const SizedBox(height: 20.0),
                  SecondaryButtonWidget(
                      caption: "Get Location",
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              title: const Text("Select Location"),
                              children: [
                                SimpleDialogOption(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    final locationController =
                                        LocationController();
                                    locationController
                                        .getLocation()
                                        .then((position) {
                                      setState(() {
                                        lat = position.latitude;
                                        lng = position.longitude;
                                        locationController
                                            .getAddressFromLatLang(position)
                                            .then((add) {
                                          streetController.text = add;
                                        });
                                      });
                                    });
                                  },
                                  child: const Text("Current Location"),
                                ),
                                SimpleDialogOption(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const GoogleMapScreen(),
                                      ),
                                    ).then((value) {
                                      if (value != null) {
                                        setState(() {
                                          address = value['address'];
                                          lat = value['lat'];
                                          lng = value['lng'];
                                          setState(() {
                                            streetController.text = address;
                                          });
                                        });
                                      }
                                    });
                                  },
                                  child: const Text("Custom Location"),
                                ),
                              ],
                            );
                          },
                        );
                      }),
                  const SizedBox(height: 20.0),
                  const RequiredTextWidget(text: "Latitude and Longitude"),
                  const SizedBox(height: 5.0),
                  (lat == 0.0 && lng == 0.0)
                      ? const SizedBox.shrink()
                      : Row(
                          children: [
                            Expanded(
                              child: ContainerTextWidget(
                                text: "lat: ${lat.toStringAsFixed(2)}",
                                icon: Ionicons.location_outline,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: ContainerTextWidget(
                                text: "lng: ${lng.toStringAsFixed(2)}",
                                icon: Ionicons.location_outline,
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: 10.0),
                  const RequiredTextWidget(text: "IDs"),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      governmentIdFile == null
                          ? const UnSelectedImageWidget()
                          : CircularImageWidget(
                              imageFile: governmentIdFile!,
                            ),
                      TextButton(
                        onPressed: () async {
                          try {
                            governmentIdFile =
                                await appImagePicker(ImageSource.gallery);
                            setState(() {});
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                          }
                        },
                        child: const Text("Upload Government ID"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      selfieWithGovernmentIdFile == null
                          ? const UnSelectedImageWidget()
                          : CircularImageWidget(
                              imageFile: selfieWithGovernmentIdFile!,
                            ),
                      TextButton(
                        onPressed: () async {
                          try {
                            selfieWithGovernmentIdFile =
                                await appImagePicker(ImageSource.camera);
                            setState(() {});
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                          }
                        },
                        child: const Text("Upload Selfie Government ID"),
                      ),
                    ],
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
                  TextFieldWidget(
                    controller: clubRegionController,
                    label: "Enter Your Club Region",
                  ),
                  const SizedBox(height: 10.0),
                  const RequiredTextWidget(text: "Club President"),
                  const SizedBox(height: 5.0),
                  TextFieldWidget(
                    controller: clubPresidentController,
                    label: "Enter Your Club President",
                  ),
                  // const SizedBox(height: 10.0),
                  // const RequiredTextWidget(text: "National President"),
                  // const SizedBox(height: 5.0),
                  // TextFieldWidget(
                  //   controller: nationalPresidentController,
                  //   label: "Enter Your National President",
                  //   focusNode: streetAddressNode,
                  // ),
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
                  // const SizedBox(height: 10.0),
                  // const RequiredTextWidget(text: "Club Secretary Name"),
                  // const SizedBox(height: 5.0),
                  // TextFieldWidget(
                  //   controller: clubSecretaryController,
                  //   label: "Select Your Club Secretary Name",
                  // ),
                  // const SizedBox(height: 10.0),
                  // const RequiredTextWidget(
                  //     text: "Club Secretary Contact Number"),
                  // const SizedBox(height: 5.0),
                  // MobileNumberTextField(
                  //   controller: mobileNumberController,
                  // ),
                  const SizedBox(height: 10.0),
                  SecondaryButtonWidget(
                    caption: "Update",
                    onPressed: () {
                      updateMember();
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
