import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class TeamProfilePage extends StatefulWidget {
  const TeamProfilePage({super.key});

  @override
  State<TeamProfilePage> createState() => _TeamProfilePageState();
}

class _TeamProfilePageState extends State<TeamProfilePage> {
  final members = <Map<String, String>>[
    {'name': 'You', 'role': 'Team Lead'},
    {'name': 'Rahul Sharma', 'role': 'Flutter Developer'},
    {'name': 'Amit Verma', 'role': 'API Integration'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Team Profile',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 38,
            backgroundColor: AppColors.primary,
            child: Icon(Icons.groups, color: AppColors.textPrimary, size: 36),
          ),
          const SizedBox(height: 14),
          const Center(
            child: Text(
              'Vishwakarma Award Team',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Center(
            child: Text(
              'Building solutions that matter',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(height: 28),
          _section(
            'Combined Skills',
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Flutter', 'Dart', 'UI/UX Design', 'Python', 'APIs']
                  .map(
                    (skill) => Chip(
                      label: Text(
                        skill,
                        style: const TextStyle(color: AppColors.accent),
                      ),
                      backgroundColor: AppColors.surface,
                      side: BorderSide.none,
                    ),
                  )
                  .toList(),
            ),
          ),
          _section(
            'Members',
            Column(
              children: [
                for (final member in members)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.surface,
                      child: Icon(Icons.person, color: AppColors.accent),
                    ),
                    title: Text(
                      member['name']!,
                      style: const TextStyle(color: AppColors.textPrimary),
                    ),
                    subtitle: Text(
                      member['role']!,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
              ],
            ),
          ),
          _section(
            'Past Projects',
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Campus Navigation App',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Smart India Hackathon prototype',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                SizedBox(height: 16),
                Text(
                  'College Event Companion',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Awarded best collaboration project',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, Widget child) => Padding(
    padding: const EdgeInsets.only(bottom: 22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.accent,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        child,
      ],
    ),
  );
}
