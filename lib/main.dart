import 'package:event_management/constants/app_colors.dart';
import 'package:event_management/screens/login/member_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Event Management',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.appTextColorPrimary,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: AppColors.primaryColor,
                statusBarIconBrightness: Brightness.light,
              ),
              iconTheme: IconThemeData(
                color: AppColors.appTextColorPrimary,
                size: 24.sp,
              ),
            ),
          ),
          home: const MemberLoginScreen(),
        );
      },
    );
  }
}
