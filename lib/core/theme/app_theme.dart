import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_theme.dart';

abstract class AppTheme {
  static final ThemeData themeData = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    textTheme: AppTextTheme.primaryTheme,
    brightness: Brightness.light,
    canvasColor: AppColors.primaryColor,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
    ),
    tabBarTheme: TabBarTheme(
        unselectedLabelStyle: AppTextTheme.primaryTheme.labelSmall,
        labelStyle: AppTextTheme.primaryTheme.labelSmall),
    cardTheme: const CardTheme(
      shadowColor: AppColors.transparent,
      surfaceTintColor: AppColors.transparent,
    ),
    badgeTheme: const BadgeThemeData(
      backgroundColor: AppColors.primaryColor,
      textStyle: TextStyle(fontSize: 10),
      largeSize: 15,
    ),
  );
}
