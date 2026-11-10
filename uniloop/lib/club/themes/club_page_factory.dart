import 'package:flutter/material.dart';
import 'club_theme_config.dart';
import 'gdg/gdg_club_page.dart';
import 'default_theme/default_club_page.dart';

/// Registry of clubs that have a custom-themed page.
/// Add new entries here when you build a custom theme for another club.
const Set<String> _customThemeClubs = {'gdg'};

/// Returns the correct page widget for a given club.
///
/// • If the club has a custom theme → returns that themed page.
/// • Otherwise → returns the generic [DefaultClubPage].
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => ClubPageFactory.buildPage(data)),
/// );
/// ```
class ClubPageFactory {
  ClubPageFactory._();

  /// Whether [clubId] has a hand-crafted custom theme.
  static bool hasCustomTheme(String clubId) =>
      _customThemeClubs.contains(clubId.toLowerCase());

  /// Build the public-facing page for the club described by [data].
  static Widget buildPage(ClubPageData data) {
    switch (data.clubId.toLowerCase()) {
      case 'gdg':
        return GdgClubPage(data: data);
      // ── Add future custom themes here ──
      // case 'robotics':
      //   return RoboticsClubPage(data: data);
      default:
        return DefaultClubPage(data: data);
    }
  }
}
