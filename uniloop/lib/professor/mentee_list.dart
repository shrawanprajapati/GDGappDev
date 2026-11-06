import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class MenteeListPage extends StatefulWidget {
  const MenteeListPage({super.key});
  @override
  State<MenteeListPage> createState() => _MenteeListPageState();
}

class _MenteeListPageState extends State<MenteeListPage> {
  final mentees = <Map<String, String>>[
    {
      'name': 'Shrawan Prajapati',
      'course': 'CSE · 2nd Year',
      'progress': 'ML research proposal · 70%',
    },
    {
      'name': 'Nisha Verma',
      'course': 'ECE · 3rd Year',
      'progress': 'Higher studies plan · 45%',
    },
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    appBar: AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      title: const Text(
        'My Mentees',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    body: mentees.isEmpty
        ? const Center(
            child: Text(
              'No mentees yet',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          )
        : ListView(
            padding: const EdgeInsets.all(20),
            children: mentees.map(_menteeTile).toList(),
          ),
  );
  Widget _menteeTile(Map<String, String> mentee) => Card(
    color: AppColors.surface,
    margin: const EdgeInsets.only(bottom: 12),
    child: ListTile(
      leading: const CircleAvatar(
        backgroundColor: AppColors.primary,
        child: Icon(Icons.person, color: AppColors.textPrimary),
      ),
      title: Text(
        mentee['name']!,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '${mentee['course']}\n${mentee['progress']}',
        style: const TextStyle(color: AppColors.textSecondary),
      ),
      isThreeLine: true,
      trailing: TextButton(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Progress details for ${mentee['name']}')),
        ),
        child: const Text(
          'View Progress',
          style: TextStyle(color: AppColors.accent),
        ),
      ),
    ),
  );
}
