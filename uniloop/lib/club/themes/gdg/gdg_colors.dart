import 'package:flutter/material.dart';

/// Google Developer Group brand colors.
class GdgColors {
  GdgColors._();

  // Google brand
  static const Color blue = Color(0xFF4285F4);
  static const Color red = Color(0xFFEA4335);
  static const Color yellow = Color(0xFFFBBC04);
  static const Color green = Color(0xFF34A853);

  // Page palette (light theme for GDG page)
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Colors.white;
  static const Color cardBorder = Color(0xFFE0E0E0);
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF5F6368);
  static const Color divider = Color(0xFFE8EAED);

  // All four Google colors for decorations
  static const List<Color> googleColors = [blue, red, yellow, green];
}
