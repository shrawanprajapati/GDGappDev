import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../home/club_home_tab.dart';
import '../events/club_events_tab.dart';
import '../profile/club_profile_tab.dart';
import '../projects/club_projects_tab.dart';

class ClubDashboard extends StatefulWidget {
  const ClubDashboard({super.key});

  @override
  State<ClubDashboard> createState() => _ClubDashboardState();
}

class _ClubDashboardState extends State<ClubDashboard> {
  int _currentIndex = 0;

  // Exact 4 tabs
  final List<Widget> _tabs = [
    const ClubHomeTab(),
    const ClubEventsTab(),
    const ClubProjectsTab(), // 3rd Tab
    const ClubProfileTab(), // 4th Tab
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Club Portal',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: () => _showSearch(context),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.textPrimary),
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
          ),
        ],
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed, // Ye 4 tabs ke liye zaruri hai
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'My Club'),
        ],
      ),
    );
  }

  void _showSearch(BuildContext context) {
    showSearch(context: context, delegate: _ClubSearchDelegate());
  }
}

class _ClubSearchDelegate extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context).copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.textSecondary),
    ),
  );
  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear)),
  ];
  @override
  Widget buildLeading(BuildContext context) => IconButton(
    onPressed: () => close(context, ''),
    icon: const Icon(Icons.arrow_back),
  );
  @override
  Widget buildResults(BuildContext context) => _result();
  @override
  Widget buildSuggestions(BuildContext context) => _result();
  Widget _result() => Center(
    child: Text(
      query.isEmpty
          ? 'Search projects, events, and members'
          : 'Search results for "$query"',
      style: const TextStyle(color: AppColors.textSecondary),
    ),
  );
}
