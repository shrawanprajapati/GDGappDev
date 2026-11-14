import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class AdminDashboard extends StatefulWidget {
  AdminDashboard({super.key});
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int tab = 0;
  final users = <Map<String, dynamic>>[
    {'name': 'Aarav Mehta', 'type': 'Student', 'banned': false},
    {'name': 'Tech Innovators Club', 'type': 'Club', 'banned': false},
    {'name': 'Dr. Maya Rao', 'type': 'Professor', 'banned': false},
  ];
  final flags = <Map<String, String>>[
    {
      'title': 'AI Resume Coach',
      'type': 'Project',
      'reason': 'Duplicate content reported',
    },
    {
      'title': 'Freshers Mixer 2026',
      'type': 'Event',
      'reason': 'Incorrect venue information',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          ['Admin Home', 'Manage Users', 'Moderate Content'][tab],
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: AppColors.textPrimary),
            onPressed: () async {
              await showModalBottomSheet(
                context: context,
                backgroundColor: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (_) => ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: Icon(Icons.person, color: AppColors.textPrimary),
                      title: Text(
                        'Profile',
                        style: TextStyle(color: AppColors.textPrimary),
                      ),
                      onTap: () {
                        /* TODO: Profile page */
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.settings,
                        color: AppColors.textPrimary,
                      ),
                      title: Text(
                        'Settings',
                        style: TextStyle(color: AppColors.textPrimary),
                      ),
                      onTap: () {
                        /* TODO: Settings page */
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: AppColors.textPrimary),
                      title: Text(
                        'Logout',
                        style: TextStyle(color: AppColors.textPrimary),
                      ),
                      onTap: () =>
                          Navigator.of(context).popUntil((r) => r.isFirst),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.report_problem,
                        color: AppColors.textPrimary,
                      ),
                      title: Text(
                        'Complaints',
                        style: TextStyle(color: AppColors.textPrimary),
                      ),
                      onTap: () {
                        /* TODO: Open complaints screen */
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.notifications_active,
                        color: AppColors.textPrimary,
                      ),
                      title: Text(
                        'Push Notification to Students',
                        style: TextStyle(color: AppColors.textPrimary),
                      ),
                      onTap: () {
                        /* TODO: Notification composer */
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.newspaper,
                        color: AppColors.textPrimary,
                      ),
                      title: Text(
                        'Add News',
                        style: TextStyle(color: AppColors.textPrimary),
                      ),
                      onTap: () {
                        /* TODO: News editor */
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: tab == 0
          ? _home()
          : tab == 1
          ? _users()
          : _moderate(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tab,
        onTap: (value) => setState(() => tab = value),
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Manage Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag_outlined),
            label: 'Moderate',
          ),
        ],
      ),
    );
  }

  Widget _home() => ListView(
    padding: EdgeInsets.all(20),
    children: [
      Text(
        'Platform overview',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 8),
      Text(
        'Keep UniLoop safe and welcoming.',
        style: TextStyle(color: AppColors.textSecondary),
      ),
      SizedBox(height: 24),
      Row(
        children: [
          _stat('Users', users.length.toString(), Icons.people_outline),
          SizedBox(width: 12),
          _stat('Flagged', flags.length.toString(), Icons.flag_outlined),
        ],
      ),
      SizedBox(height: 20),
      _action(
        'Review users',
        'Ban or restore accounts',
        () => setState(() => tab = 1),
      ),
      _action(
        'Moderate content',
        'Approve or reject reports',
        () => setState(() => tab = 2),
      ),
    ],
  );
  Widget _users() => ListView(
    padding: EdgeInsets.all(20),
    children: [
      Text(
        'Students, clubs, and professors',
        style: TextStyle(color: AppColors.textSecondary),
      ),
      SizedBox(height: 16),
      ...users.map(_userTile),
    ],
  );
  Widget _userTile(Map<String, dynamic> user) => Card(
    color: AppColors.surface,
    child: ListTile(
      leading: Icon(Icons.person, color: AppColors.accent),
      title: Text(user['name'], style: TextStyle(color: AppColors.textPrimary)),
      subtitle: Text(
        user['type'],
        style: TextStyle(color: AppColors.textSecondary),
      ),
      trailing: TextButton(
        onPressed: () => setState(() => user['banned'] = !user['banned']),
        child: Text(
          user['banned'] ? 'Restore' : 'Ban',
          style: TextStyle(color: AppColors.accent),
        ),
      ),
      onLongPress: () {
        setState(() => users.remove(user));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User deleted from the mock directory.')),
        );
      },
    ),
  );
  Widget _moderate() => ListView(
    padding: EdgeInsets.all(20),
    children: [
      Text(
        'Flagged projects and events',
        style: TextStyle(color: AppColors.textSecondary),
      ),
      SizedBox(height: 16),
      ...flags.map(
        (flag) => Card(
          color: AppColors.surface,
          child: ListTile(
            title: Text(
              flag['title']!,
              style: TextStyle(color: AppColors.textPrimary),
            ),
            subtitle: Text(
              '${flag['type']} · ${flag['reason']}',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () => setState(() => flags.remove(flag)),
                  child: Text(
                    'Approve',
                    style: TextStyle(color: AppColors.accent),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() => flags.remove(flag)),
                  child: Text(
                    'Reject',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
  Widget _stat(String label, String value, IconData icon) => Expanded(
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.accent),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(label, style: TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    ),
  );
  Widget _action(String title, String subtitle, VoidCallback onTap) => Card(
    color: AppColors.surface,
    child: ListTile(
      onTap: onTap,
      title: Text(title, style: TextStyle(color: AppColors.textPrimary)),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: AppColors.textSecondary),
      ),
      trailing: Icon(Icons.chevron_right, color: AppColors.accent),
    ),
  );
}
