import 'package:flutter/material.dart';

import 'app_sizes.dart';

abstract class AppTextTheme {
  static TextTheme primaryTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: FontSize.fontSize32,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: TextStyle(
      fontSize: FontSize.fontSize32,
      fontWeight: FontWeight.w500,
    ),
    displaySmall: TextStyle(
      fontSize: FontSize.fontSize32,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      fontSize: FontSize.fontSize24,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      fontSize: FontSize.fontSize24,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontSize: FontSize.fontSize24,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      fontSize: FontSize.fontSize20,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      fontSize: FontSize.fontSize20,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      fontSize: FontSize.fontSize20,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontSize: FontSize.fontSize16,
      fontWeight: FontWeight.w700,
    ),
    labelMedium: TextStyle(
      fontSize: FontSize.fontSize16,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      fontSize: FontSize.fontSize16,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: TextStyle(
      fontSize: FontSize.fontSize14,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      fontSize: FontSize.fontSize14,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: TextStyle(
      fontSize: FontSize.fontSize14,
      fontWeight: FontWeight.w400,
    ),
  );
}
