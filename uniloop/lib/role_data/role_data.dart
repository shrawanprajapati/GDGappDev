// lib/role_data/role_data.dart
/// What the universal search works with.
class SearchItem {
  const SearchItem({
    required this.id, // optional – useful for navigation later
    required this.type, // e.g. Event, Member, Project
    required this.title,
    required this.subtitle,
    this.extra, // any extra payload you need
  });

  final String id;
  final String type; // free‑form string – you can use an enum if you like
  final String title;
  final String subtitle;
  final dynamic extra;
}

class RoleMockData {
  // -------- Club ----------
  static const List<SearchItem> clubItems = [
    SearchItem(
      id: 'e1',
      type: 'Event',
      title: 'Tech Fest 2024',
      subtitle: 'Oct 24 • Main Auditorium',
    ),
    SearchItem(
      id: 'e2',
      type: 'Event',
      title: 'GDG Induction Task',
      subtitle: 'Nov 01 • Online',
    ),
    SearchItem(
      id: 'm1',
      type: 'Member',
      title: 'Tech Innovators Club',
      subtitle: 'Club – 12 members',
    ),
    SearchItem(
      id: 'p1',
      type: 'Project',
      title: 'AI Resume Coach',
      subtitle: 'Industry Project – Acme Labs',
    ),
  ];

  // -------- Student ----------
  static const List<SearchItem> studentItems = [
    SearchItem(
      id: 'p100',
      type: 'Project',
      title: 'Campus Map Revamp',
      subtitle: 'Student Project – Geo Team',
    ),
    SearchItem(
      id: 'e200',
      type: 'Event',
      title: 'Flutter Hackathon',
      subtitle: 'Dec 02 • Lab 3',
    ),
    SearchItem(
      id: 'c300',
      type: 'Club',
      title: 'Design Club',
      subtitle: '15 members – UI/UX',
    ),
  ];

  // -------- Admin ----------
  static const List<SearchItem> adminItems = [
    SearchItem(
      id: 'c001',
      type: 'Complaint',
      title: 'App crash on login',
      subtitle: 'Reported by Student – urgent',
    ),
    SearchItem(
      id: 'n001',
      type: 'Notification',
      title: 'Push notification to all students',
      subtitle: 'Scheduled for tomorrow',
    ),
    SearchItem(
      id: 'n002',
      type: 'News',
      title: 'New semester timetable released',
      subtitle: '',
    ),
  ];

  // -------- Alumni ----------
  static const List<SearchItem> alumniItems = [
    SearchItem(
      id: 'op001',
      type: 'Opportunity',
      title: 'Summer Internship – Acme Labs',
      subtitle: 'Software Engineer – 8 weeks',
    ),
    SearchItem(
      id: 'm001',
      type: 'Mentee Request',
      title: 'Guidance on thesis',
      subtitle: 'Student: Priya Sharma',
    ),
  ];

  // -------- Industry ----------
  static const List<SearchItem> industryItems = [
    SearchItem(
      id: 'proj001',
      type: 'Project',
      title: 'AI Resume Coach',
      subtitle: 'Full‑stack project – Flutter + Firebase',
    ),
    SearchItem(
      id: 'job001',
      type: 'Job',
      title: 'Frontend Engineer',
      subtitle: 'Location: Bangalore, Remote option',
    ),
  ];

  // -------- Professor ----------
  static const List<SearchItem> professorItems = [
    SearchItem(
      id: 'projP01',
      type: 'Mentee Project',
      title: 'Smart Campus Navigation',
      subtitle: 'Student team – 4 members',
    ),
    SearchItem(
      id: 'notifP01',
      type: 'Notification',
      title: 'New research grant available',
      subtitle: '',
    ),
  ];
}