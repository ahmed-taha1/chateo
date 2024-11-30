import 'package:flutter/material.dart';
import 'app_colors.dart';

enum AppTheme {
  light("light"),
  dark("dark");

  const AppTheme(this.value);

  final String value;
}

final appThemeData = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.blackPurple,
    scaffoldBackgroundColor: AppColors.white,
    hintColor: const Color(0xFF697885),
    hoverColor: const Color(0xFFECF5F3),
    secondaryHeaderColor: const Color(0xFF717171),
    primaryColorLight: AppColors.blue,
    indicatorColor: const Color(0xFF4eb89d),
  ),

  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.white,
    scaffoldBackgroundColor: const Color(0xFF1F2128),
    hintColor: const Color(0xFFA3A3A3),
    hoverColor: const Color(0xFF353B0F),
    secondaryHeaderColor: const Color(0xFFBEBEBE),
    primaryColorLight: const Color(0xFF375FFF),
  ),
};
