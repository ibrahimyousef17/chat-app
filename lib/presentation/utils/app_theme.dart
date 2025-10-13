import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme{
  static const Color primaryColor = Color(0xff3598DB);
  static const Color blackColor = Color(0xff303030);
  static const Color whiteColor = Color(0xffFFFFFF);

  static ThemeData appTheme = ThemeData(
    primaryColor: primaryColor ,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
       fontSize: 24.sp,
       fontWeight: FontWeight.bold,
       color:  blackColor
      ),
      titleMedium: TextStyle(
       fontSize: 20.sp,
       fontWeight: FontWeight.bold,
       color:  whiteColor
      ),
      titleSmall: TextStyle(
       fontSize: 14.sp,
       fontWeight: FontWeight.bold,
       color:  blackColor
      ),
    )
  );
}