import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../home/club_home_tab.dart';
import '../events/club_events_tab.dart';
import '../profile/club_profile_tab.dart';
import '../projects/club_projects_tab.dart'; // 👈 Naya Import

class ClubDashboard extends StatefulWidget {
  const ClubDashboard({super.key});

  @override
  State<ClubDashboard> createState() => _ClubDashboardState();
}

class _ClubDashboardState extends State<ClubDashboard> {
  int _currentIndex = 0;

  // 👈 Naya Tab Add kiya
  final List<Widget> _tabs = [
    const ClubHomeTab(),
    const ClubEventsTab(),
    const ClubProjectsTab(), // Projects Tab
    const ClubProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Club Portal', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.logout, color: AppColors.textPrimary), onPressed: () => Navigator.popUntil(context, (route) => route.isFirst))
        ],
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed, // 4 items ke liye zaruri hai
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Projects'), // 👈 Naya
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'My Club'),
        ],
      ),
    );
  }
}