import 'package:flutter/material.dart';
import 'colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.pink,
    hintColor: AppColors.pink,
    scaffoldBackgroundColor: AppColors.white1,
    dividerColor: AppColors.pink,
    cardColor: AppColors.white2,
    canvasColor: AppColors.grey,
    indicatorColor: AppColors.black1,
    textTheme: TextTheme(
      headlineLarge: TextStyle(
          color: AppColors.black2, fontSize: 36, fontWeight: FontWeight.w500),
      headlineMedium: TextStyle(
          color: AppColors.black2, fontSize: 32, fontWeight: FontWeight.w500),
      headlineSmall: TextStyle(
          color: AppColors.black2, fontSize: 24, fontWeight: FontWeight.w500),
      labelLarge: TextStyle(
          color: AppColors.black2, fontSize: 16, fontWeight: FontWeight.w700),
      labelSmall: TextStyle(
          color: AppColors.black2, fontSize: 14, fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(
          color: AppColors.black2, fontSize: 16, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(
          color: AppColors.black2, fontSize: 14, fontWeight: FontWeight.w500),
      bodySmall: TextStyle(
          color: AppColors.black2, fontSize: 12, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(fontSize: 14, color: AppColors().buttonLable),
    ),
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    primaryColor: AppColors.pink,
    hintColor: AppColors.white1,
    dividerColor: AppColors.yellow,
    scaffoldBackgroundColor: AppColors.black1,
    cardColor: AppColors.black2,
    canvasColor: AppColors.black2,
    indicatorColor: AppColors.black1,
    textTheme: TextTheme(
      headlineLarge: TextStyle(
          color: AppColors.white2, fontSize: 36, fontWeight: FontWeight.w500),
      headlineMedium: TextStyle(
          color: AppColors.white2, fontSize: 32, fontWeight: FontWeight.w500),
      headlineSmall: TextStyle(
          color: AppColors.white2, fontSize: 24, fontWeight: FontWeight.w500),
      labelLarge: TextStyle(
          color: AppColors.white2, fontSize: 16, fontWeight: FontWeight.w700),
      labelSmall: TextStyle(
          color: AppColors.white2, fontSize: 14, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(
          color: AppColors.white2, fontSize: 16, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(
          color: AppColors.white2, fontSize: 14, fontWeight: FontWeight.w500),
      bodySmall: TextStyle(
          color: AppColors.white2, fontSize: 12, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(fontSize: 14, color: AppColors().buttonLable),
    ),
    brightness: Brightness.light,
  );
}
