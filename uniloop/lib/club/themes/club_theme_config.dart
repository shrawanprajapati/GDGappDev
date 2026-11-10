import 'package:flutter/material.dart';

/// Data model describing a club for the public-facing page.
/// Later this will come from a database; for now it holds mock data.
class ClubPageData {
  const ClubPageData({
    required this.clubId,
    required this.clubName,
    required this.instituteName,
    required this.description,
    this.logoIcon,
    this.accentColor,
    this.events = const [],
    this.team = const [],
    this.socialLinks = const {},
    this.pastHighlights = const [],
  });

  final String clubId;
  final String clubName;
  final String instituteName;
  final String description;
  final IconData? logoIcon;
  final Color? accentColor;
  final List<ClubEvent> events;
  final List<ClubTeamMember> team;
  final Map<String, String> socialLinks; // e.g. {'github': 'https://...'}
  final List<String> pastHighlights;
}

class ClubEvent {
  const ClubEvent({
    required this.title,
    required this.date,
    required this.time,
    required this.venue,
    this.category = 'Event',
    this.registrations = 0,
    this.isUpcoming = true,
    this.description = '',
  });

  final String title;
  final String date;
  final String time;
  final String venue;
  final String category;
  final int registrations;
  final bool isUpcoming;
  final String description;
}

class ClubTeamMember {
  const ClubTeamMember({
    required this.name,
    required this.role,
    this.department = '',
  });

  final String name;
  final String role;
  final String department;
}
