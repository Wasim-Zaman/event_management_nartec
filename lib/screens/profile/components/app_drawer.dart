import 'package:event_management/constants/app_colors.dart';
import 'package:event_management/providers/profile/member_profile.dart';
import 'package:event_management/screens/profile/member_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.appWhiteColor,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.appWhiteColor,
                    child: Icon(
                      Ionicons.person_outline,
                      color: AppColors.primaryColor,
                      size: 40,
                    ),
                  ),
                  Text(
                    context.read<MemberProfile>().email,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            DrawerItem(
              title: 'My Profile',
              icon: Ionicons.person_outline,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MemberProfileScreen(),
                  ),
                );
              },
            ),
            DrawerItem(
              title: 'Current Events',
              icon: Ionicons.calendar_outline,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            DrawerItem(
              title: 'Help Desk',
              icon: Ionicons.help_outline,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            DrawerItem(
              title: 'Eagles Club',
              icon: Ionicons.people_outline,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryColor,
          child: Icon(
            icon,
            color: AppColors.appWhiteColor,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 15,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}