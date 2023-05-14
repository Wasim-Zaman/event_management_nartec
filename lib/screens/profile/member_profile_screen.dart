// ignore_for_file: library_private_types_in_public_api

import 'package:event_management/constants/app_colors.dart';
import 'package:event_management/controllers/profile/profile_controller.dart';
import 'package:event_management/models/profile/profile_model.dart';
import 'package:event_management/providers/profile/member_profile.dart';
import 'package:event_management/utils/snackbars/app_snackbars.dart';
import 'package:event_management/widgets/loading_widget/app_loading_widget.dart';
import 'package:event_management/widgets/text/container_text_widget.dart';
import 'package:event_management/widgets/text/heading_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class MemberProfileScreen extends StatefulWidget {
  const MemberProfileScreen({super.key});

  @override
  _MemberProfileScreenState createState() => _MemberProfileScreenState();
}

class _MemberProfileScreenState extends State<MemberProfileScreen>
    with SingleTickerProviderStateMixin {
  bool screenLoaded = false;

  late TabController tabController = TabController(
    length: 2,
    vsync: this,
    initialIndex: 0,
  );

  late ProfileModel profileModel;
  late String email, password;
  @override
  void initState() {
    super.initState();

    // Get email and password from provider
    email = context.read<MemberProfile>().email;
    password = context.read<MemberProfile>().password;

    // clear the provider
    context.read<MemberProfile>().reset();

    // Api calls
    ProfileController.getMember(email, password).then((model) {
      setState(() {
        profileModel = model;
        screenLoaded = true;
      });
    }).onError((error, stackTrace) {
      AppSnackbars.errorSnackbar(
        context,
        error.toString().replaceAll("Exception:", ""),
      );
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Registration'),
        leading: IconButton(
          icon: const Icon(Ionicons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeadingTextWidget(text: "First Name"),
                  ContainerTextWidget(
                    text: profileModel.firstName.toString(),
                    icon: Ionicons.person_outline,
                  ),
                  const HeadingTextWidget(text: "Last Name"),
                  ContainerTextWidget(
                    text: profileModel.lastName.toString(),
                    icon: Ionicons.person_outline,
                  ),
                  const HeadingTextWidget(text: "Email"),
                  ContainerTextWidget(
                    text: profileModel.email.toString(),
                    icon: Ionicons.mail_outline,
                  ),
                  const HeadingTextWidget(text: "Password"),
                  ContainerTextWidget(
                    text: profileModel.password.toString(),
                    icon: Ionicons.lock_closed_outline,
                  ),
                  const HeadingTextWidget(text: "Street Address"),
                  ContainerTextWidget(
                    text: profileModel.streetAddress.toString(),
                    icon: Ionicons.home_outline,
                  ),
                  const HeadingTextWidget(text: "Province"),
                  ContainerTextWidget(
                    text: profileModel.province.toString(),
                    icon: Ionicons.location_outline,
                  ),
                  const HeadingTextWidget(text: "City"),
                  ContainerTextWidget(
                    text: profileModel.city.toString(),
                    icon: Ionicons.location_outline,
                  ),
                  const HeadingTextWidget(text: "Barangay"),
                  ContainerTextWidget(
                    text: profileModel.barangay.toString(),
                    icon: Ionicons.location_outline,
                  ),
                ],
              ),
            ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeadingTextWidget(text: "Club Name"),
                  ContainerTextWidget(
                    text: profileModel.clubName.toString(),
                    icon: Ionicons.people_outline,
                  ),
                  const HeadingTextWidget(text: "Club Region"),
                  ContainerTextWidget(
                    text: profileModel.clubRegion.toString(),
                    icon: Ionicons.location_outline,
                  ),
                  const HeadingTextWidget(text: "Club President"),
                  ContainerTextWidget(
                    text: profileModel.clubPresident.toString(),
                    icon: Ionicons.person_outline,
                  ),
                  const HeadingTextWidget(text: "National President"),
                  ContainerTextWidget(
                    text: profileModel.nationalPresident.toString(),
                    icon: Ionicons.person_outline,
                  ),
                  const HeadingTextWidget(text: "Date Joined"),
                  ContainerTextWidget(
                    text: profileModel.date.toString(),
                    icon: Ionicons.calendar_outline,
                  ),
                  const HeadingTextWidget(
                    text: "Do You Already Have TFOE-PE ID?",
                  ),
                  ContainerTextWidget(
                    text: profileModel.peID.toString(),
                    icon: Ionicons.calendar_outline,
                  ),
                  const HeadingTextWidget(text: "Club Secretary Name"),
                  ContainerTextWidget(
                    text: profileModel.clubSecretryName.toString(),
                    icon: Ionicons.person_outline,
                  ),
                  const HeadingTextWidget(
                    text: "Club Secretary Contact Number",
                  ),
                  ContainerTextWidget(
                    text: profileModel.clubSecretryNO.toString(),
                    icon: Ionicons.call_outline,
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
