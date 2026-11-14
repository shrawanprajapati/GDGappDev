import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../home/club_home_tab.dart';
import '../events/club_events_tab.dart';
import '../profile/club_profile_tab.dart';
import '../projects/club_projects_tab.dart';
import '../events/create_event_page.dart';
import '../../core/role_search_delegate.dart';
import '../../role_data/role_data.dart';

// ---------------------------------------------------
// OPTIONAL: keep ClubDrawer in this file or import it
// ---------------------------------------------------
class ClubDrawer extends StatelessWidget {
  const ClubDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ClubColors.surface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: ClubColors.background),
            child: Text(
              'Club Menu',
              style: TextStyle(
                color: ClubColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: ClubColors.textPrimary),
            title: const Text(
              'Profile',
              style: TextStyle(color: ClubColors.textPrimary),
            ),
            onTap: () {
              /* TODO: Open profile page */
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: ClubColors.textPrimary),
            title: const Text(
              'Settings',
              style: TextStyle(color: ClubColors.textPrimary),
            ),
            onTap: () {
              /* TODO: Open settings page */
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: ClubColors.textPrimary),
            title: const Text(
              'Logout',
              style: TextStyle(color: ClubColors.textPrimary),
            ),
            onTap: () => Navigator.of(context).popUntil((r) => r.isFirst),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.event, color: ClubColors.textPrimary),
            title: const Text(
              'Add Event',
              style: TextStyle(color: ClubColors.textPrimary),
            ),
            onTap: () {
              // First close the drawer
              Navigator.of(context).pop();
              // Then push the existing CreateEventPage
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CreateEventPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.notifications,
              color: ClubColors.textPrimary,
            ),
            title: const Text(
              'Release Notification to Students',
              style: TextStyle(color: ClubColors.textPrimary),
            ),
            onTap: () {
              /* TODO: Notification composer */
            },
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------
// MAIN DASHBOARD (with Builder fix)
// ---------------------------------------------------
class ClubDashboard extends StatefulWidget {
  const ClubDashboard({super.key});

  @override
  State<ClubDashboard> createState() => _ClubDashboardState();
}

class _ClubDashboardState extends State<ClubDashboard> {
  int _currentIndex = 0;

  // Exact 4 tabs
  final List<Widget> _tabs = const [
    ClubHomeTab(),
    ClubEventsTab(),
    ClubProjectsTab(),
    ClubProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClubColors.background,
      drawer: const ClubDrawer(), // <- side drawer

      appBar: AppBar(
        backgroundColor: ClubColors.background,
        elevation: 0,

        // ----- LEFT‑HAND MENU (opens drawer) -----
        leading: Builder(
          builder: (innerContext) => IconButton(
            icon: const Icon(Icons.menu, color: ClubColors.textPrimary),
            onPressed: () => Scaffold.of(innerContext).openDrawer(),
          ),
        ),

        // ----- TITLE -----
        title: const Text(
          'Club Portal',
          style: TextStyle(
            color: ClubColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),

        // ----- RIGHT‑HAND ACTIONS (search) -----
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: ClubColors.textPrimary),
            onPressed: () => _showSearch(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: ClubColors.surface,
        selectedItemColor: ClubColors.accent,
        unselectedItemColor: ClubColors.textSecondary,
        type: BottomNavigationBarType.fixed,
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
    showSearch(
      context: context,
      delegate: RoleSearchDelegate(
        roleName: 'Club',
        items: RoleMockData.clubItems, // <-- role‑specific data
      ),
    );
  }
}
