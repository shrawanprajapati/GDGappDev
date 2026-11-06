import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});
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
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
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
        items: const [
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
    padding: const EdgeInsets.all(20),
    children: [
      const Text(
        'Platform overview',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        'Keep UniLoop safe and welcoming.',
        style: TextStyle(color: AppColors.textSecondary),
      ),
      const SizedBox(height: 24),
      Row(
        children: [
          _stat('Users', users.length.toString(), Icons.people_outline),
          const SizedBox(width: 12),
          _stat('Flagged', flags.length.toString(), Icons.flag_outlined),
        ],
      ),
      const SizedBox(height: 20),
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
    padding: const EdgeInsets.all(20),
    children: [
      const Text(
        'Students, clubs, and professors',
        style: TextStyle(color: AppColors.textSecondary),
      ),
      const SizedBox(height: 16),
      ...users.map(_userTile),
    ],
  );
  Widget _userTile(Map<String, dynamic> user) => Card(
    color: AppColors.surface,
    child: ListTile(
      leading: const Icon(Icons.person, color: AppColors.accent),
      title: Text(
        user['name'],
        style: const TextStyle(color: AppColors.textPrimary),
      ),
      subtitle: Text(
        user['type'],
        style: const TextStyle(color: AppColors.textSecondary),
      ),
      trailing: TextButton(
        onPressed: () => setState(() => user['banned'] = !user['banned']),
        child: Text(
          user['banned'] ? 'Restore' : 'Ban',
          style: const TextStyle(color: AppColors.accent),
        ),
      ),
      onLongPress: () {
        setState(() => users.remove(user));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User deleted from the mock directory.'),
          ),
        );
      },
    ),
  );
  Widget _moderate() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Text(
        'Flagged projects and events',
        style: TextStyle(color: AppColors.textSecondary),
      ),
      const SizedBox(height: 16),
      ...flags.map(
        (flag) => Card(
          color: AppColors.surface,
          child: ListTile(
            title: Text(
              flag['title']!,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
            subtitle: Text(
              '${flag['type']} · ${flag['reason']}',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () => setState(() => flags.remove(flag)),
                  child: const Text(
                    'Approve',
                    style: TextStyle(color: AppColors.accent),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() => flags.remove(flag)),
                  child: const Text(
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
      padding: const EdgeInsets.all(16),
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
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    ),
  );
  Widget _action(String title, String subtitle, VoidCallback onTap) => Card(
    color: AppColors.surface,
    child: ListTile(
      onTap: onTap,
      title: Text(title, style: const TextStyle(color: AppColors.textPrimary)),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: AppColors.textSecondary),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.accent),
    ),
  );
}
