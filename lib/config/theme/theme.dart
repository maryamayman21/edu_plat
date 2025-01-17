
import 'package:edu_platt/core/utils/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
      primaryColor: color.primaryColor,
      colorScheme: const ColorScheme.light(
        primary: color.primaryColor, //
        onPrimary: Colors.white, //
        onSurface: Colors.black, //
      ),
      dialogBackgroundColor: Colors.white,
      //
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue, //
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(
          size: 24.r,
        ),
        unselectedIconTheme: IconThemeData(size: 22.r),
        backgroundColor: Colors.transparent,
        selectedItemColor: color.primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
      ),
      textTheme: TextTheme(


        titleMedium: TextStyle(
            fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black),
        headlineSmall: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: color.primaryColor),
        headlineMedium: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
      color: color.primaryColor,
      shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.5), // Shadow color
              offset: const Offset(2, 2), // Position of the shadow
              blurRadius: 4, // How blurry the shadow is
        ),
      ],
    ),

          bodyLarge: TextStyle(color: Colors.black),  // Primary body text
          bodyMedium: TextStyle(color: Colors.black),
        headlineLarge: TextStyle(
            fontSize: 14.sp, fontWeight: FontWeight.w800, color: Colors.black),
        bodySmall: TextStyle(
        fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black),
    // bodyMedium: TextStyle(
    //         fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
        labelSmall: TextStyle(
            fontSize: 13.sp, fontWeight: FontWeight.w700, color: Colors.white),
      ));
}