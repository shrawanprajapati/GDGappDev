import 'package:flutter/material.dart';
import 'app_colors.dart';

enum ThemePreset { warm, lavender, ocean }

class AppThemeSettings {
  final ThemeMode mode;
  final ThemePreset preset;

  const AppThemeSettings({
    this.mode = ThemeMode.dark,
    this.preset = ThemePreset.warm,
  });
}

class AppTheme {
  AppTheme._();

  static const ThemePreset defaultPreset = ThemePreset.warm;
  static const ThemeMode defaultMode = ThemeMode.light;

  static final settings = ValueNotifier(
    const AppThemeSettings(mode: defaultMode, preset: defaultPreset),
  );

  static void setDarkMode(bool enabled) {
    _syncAppColors(
      enabled ? ThemeMode.dark : ThemeMode.light,
      settings.value.preset,
    );
    settings.value = AppThemeSettings(
      mode: enabled ? ThemeMode.dark : ThemeMode.light,
      preset: settings.value.preset,
    );
  }

  static void setPreset(ThemePreset preset) {
    _syncAppColors(settings.value.mode, preset);
    settings.value = AppThemeSettings(
      mode: settings.value.mode,
      preset: preset,
    );
  }

  static void syncCurrentColors() {
    _syncAppColors(settings.value.mode, settings.value.preset);
  }

  static Color _primary(ThemePreset preset) {
    switch (preset) {
      case ThemePreset.lavender:
        return const Color(0xFF8B6FE8);
      case ThemePreset.ocean:
        return const Color(0xFF3E9BD3);
      case ThemePreset.warm:
        return const Color(0xFFC87552);
    }
  }

  static Color _accent(ThemePreset preset) {
    switch (preset) {
      case ThemePreset.lavender:
        return const Color(0xFFE39AE8);
      case ThemePreset.ocean:
        return const Color(0xFF62D7C9);
      case ThemePreset.warm:
        return const Color(0xFFE7B15A);
    }
  }

  static Color _background(ThemePreset preset, bool dark) {
    switch (preset) {
      case ThemePreset.lavender:
        return dark ? const Color(0xFF171321) : const Color(0xFFFAF7FF);
      case ThemePreset.ocean:
        return dark ? const Color(0xFF0D1920) : const Color(0xFFF3FBFF);
      case ThemePreset.warm:
        return dark ? const Color(0xFF171311) : const Color(0xFFFFF8F1);
    }
  }

  static Color _surface(ThemePreset preset, bool dark) {
    switch (preset) {
      case ThemePreset.lavender:
        return dark ? const Color(0xFF261D38) : const Color(0xFFF0EAFF);
      case ThemePreset.ocean:
        return dark ? const Color(0xFF132B37) : const Color(0xFFE5F4FA);
      case ThemePreset.warm:
        return dark ? const Color(0xFF261D19) : const Color(0xFFFFEFE3);
    }
  }

  static Color _textPrimary(ThemePreset preset, bool dark) {
    if (dark) return const Color(0xFFFFF4E8);
    switch (preset) {
      case ThemePreset.lavender:
        return const Color(0xFF2B213D);
      case ThemePreset.ocean:
        return const Color(0xFF18313D);
      case ThemePreset.warm:
        return const Color(0xFF35241D);
    }
  }

  static Color _textSecondary(ThemePreset preset, bool dark) {
    if (dark) return const Color(0xFFCDBBAE);
    switch (preset) {
      case ThemePreset.lavender:
        return const Color(0xFF6E5B82);
      case ThemePreset.ocean:
        return const Color(0xFF527180);
      case ThemePreset.warm:
        return const Color(0xFF765F52);
    }
  }

  static void _syncAppColors(ThemeMode mode, ThemePreset preset) {
    final dark = mode == ThemeMode.dark;
    AppColors.primary = _primary(preset);
    AppColors.accent = _accent(preset);
    AppColors.background = _background(preset, dark);
    AppColors.surface = _surface(preset, dark);
    AppColors.textPrimary = _textPrimary(preset, dark);
    AppColors.textSecondary = _textSecondary(preset, dark);
  }

  static ThemeData get dark => _buildTheme(true, settings.value.preset);

  static ThemeData get light => _buildTheme(false, settings.value.preset);

  static ThemeData _buildTheme(bool dark, ThemePreset preset) {
    final primary = _primary(preset);
    final accent = _accent(preset);
    final background = _background(preset, dark);
    final surface = _surface(preset, dark);
    final text = _textPrimary(preset, dark);
    final secondary = _textSecondary(preset, dark);

    return ThemeData(
      brightness: dark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: background,
      colorScheme: (dark ? const ColorScheme.dark() : const ColorScheme.light())
          .copyWith(
            primary: primary,
            secondary: accent,
            surface: surface,
            onSurface: text,
            onPrimary: text,
          ),
      fontFamily: 'Roboto',
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: text,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: text,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: secondary),
      ),
      dividerTheme: DividerThemeData(
        color: dark ? Colors.white12 : primary.withValues(alpha: .15),
      ),
    );
  }
}
