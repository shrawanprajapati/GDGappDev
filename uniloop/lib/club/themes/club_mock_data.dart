import 'club_theme_config.dart';

/// Central place for all club mock data.
/// Replace with a database call later.
class ClubMockData {
  ClubMockData._();

  /// GDG – Google Developer Group (custom themed)
  static const ClubPageData gdg = ClubPageData(
    clubId: 'gdg',
    clubName: 'Google Developer Group',
    instituteName: 'IIT Indore',
    description:
        'Google Developer Groups (GDG) is a community of developers who '
        'are interested in Google\'s developer technology. We organize '
        'workshops, hackathons, study jams, and tech talks to help '
        'students grow beyond the classroom. From Flutter to Firebase, '
        'from AI/ML to Cloud — we build, learn, and grow together.',
    events: [
      // Featured event (first one)
      ClubEvent(
        title: 'Game Development Workshop',
        date: 'Friday, 30th Oct',
        time: '6:30 PM onwards',
        venue: 'Will be shared on email',
        category: 'Workshop',
        registrations: 85,
        isUpcoming: true,
        description:
            'Learn to build your first game using Godot engine. '
            'No prior game dev experience needed!',
      ),
      ClubEvent(
        title: 'Flutter Forward Extended',
        date: 'Nov 15',
        time: '10:00 AM',
        venue: 'Main Auditorium',
        category: 'Tech Talk',
        registrations: 120,
        isUpcoming: true,
      ),
      ClubEvent(
        title: 'Cloud Study Jam',
        date: 'Nov 22',
        time: '3:00 PM',
        venue: 'CS Lab 3',
        category: 'Study Jam',
        registrations: 60,
        isUpcoming: true,
      ),
      ClubEvent(
        title: 'DevFest 2024',
        date: 'Dec 05',
        time: '9:00 AM',
        venue: 'Convention Centre',
        category: 'Conference',
        registrations: 250,
        isUpcoming: true,
      ),
    ],
    team: [
      ClubTeamMember(
        name: 'Shrawan Prajapati',
        role: 'Lead',
        department: 'CSE 2026',
      ),
      ClubTeamMember(
        name: 'Rahul Sharma',
        role: 'Web Dev Lead',
        department: 'CSE 2025',
      ),
      ClubTeamMember(
        name: 'Priya Singh',
        role: 'AI/ML Lead',
        department: 'ECE 2026',
      ),
      ClubTeamMember(
        name: 'Kabir Mehta',
        role: 'Flutter Lead',
        department: 'CSE 2026',
      ),
      ClubTeamMember(
        name: 'Ananya Gupta',
        role: 'Design Lead',
        department: 'B.Des 2025',
      ),
      ClubTeamMember(
        name: 'Rohan Iyer',
        role: 'Cloud Lead',
        department: 'CSE 2026',
      ),
    ],
    socialLinks: {
      'GitHub': 'https://github.com/gdg-iiti',
      'LinkedIn': 'https://linkedin.com/company/gdg-iiti',
      'Instagram': 'https://instagram.com/gdg_iiti',
      'YouTube': 'https://youtube.com/@gdgiiti',
      'Website': 'https://gdg.community.dev',
      'Discord': 'https://discord.gg/gdgiiti',
    },
    pastHighlights: [
      'DevFest 2023 – 300+ attendees',
      'Flutter Hackathon – 45 teams',
      'Cloud Study Jam – 80 certified',
      'AI/ML Bootcamp – 3 weeks',
      'Open Source Week',
    ],
  );

  /// Helper: return the right ClubPageData by club ID.
  /// Falls back to a generic placeholder.
  static ClubPageData getByClubId(String clubId) {
    switch (clubId.toLowerCase()) {
      case 'gdg':
        return gdg;
      default:
        // Generic fallback – in production you'd query a DB.
        return ClubPageData(
          clubId: clubId,
          clubName: clubId,
          instituteName: 'University',
          description: 'A student club at the university.',
        );
    }
  }
}
