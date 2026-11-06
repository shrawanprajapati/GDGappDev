import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.surface,
        ),
        fontFamily: 'Roboto',
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textSecondary,
          ),
        ),
      );
}