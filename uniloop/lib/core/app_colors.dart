import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Colors
  // Warm, comfortable campus palette.
  static Color primary = const Color(0xFFC87552); // Terracotta
  static Color accent = const Color(0xFFE7B15A); // Warm gold
  static Color background = const Color(0xFF171311); // Espresso background
  static Color surface = const Color(0xFF261D19); // Warm card surface
  static Color textPrimary = const Color(0xFFFFF4E8);
  static Color textSecondary = const Color(0xFFCDBBAE);

  // Light mode keeps the same warm identity while opening the interface up.
  static const Color lightBackground = Color(0xFFFFF8F1);
  static const Color lightSurface = Color(0xFFFFEFE3);
  static const Color lightTextPrimary = Color(0xFF35241D);
  static const Color lightTextSecondary = Color(0xFF765F52);

  static LinearGradient get brandGradient => LinearGradient(
    colors: [primary, Color(0xFFD99262), accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

/// Fixed palette for the existing club experience.
/// Club screens intentionally do not follow student/portal theme presets.
class ClubColors {
  ClubColors._();

  static const Color primary = Color(0xFFC87552);
  static const Color accent = Color(0xFFE7B15A);
  static const Color background = Color(0xFF171311);
  static const Color surface = Color(0xFF261D19);
  static const Color textPrimary = Color(0xFFFFF4E8);
  static const Color textSecondary = Color(0xFFCDBBAE);
}
