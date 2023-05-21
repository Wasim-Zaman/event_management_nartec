import 'package:event_management/common/constants/app_theme.dart';
import 'package:event_management/providers/map/google_map_provider.dart';
import 'package:event_management/providers/profile/member_profile.dart';
import 'package:event_management/screens/login/member_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(context.width(), context.height()),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MemberProfile(),
            ),
            ChangeNotifierProvider(
              create: (context) => GoogleMapProvider(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Event Management',
            theme: AppTheme.themeData,
            home: const MemberLoginScreen(),
          ),
        );
      },
    );
  }
}
