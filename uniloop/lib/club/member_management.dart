import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class MemberManagementPage extends StatefulWidget {
  const MemberManagementPage({super.key});
  @override
  State<MemberManagementPage> createState() => _MemberManagementPageState();
}

class _MemberManagementPageState extends State<MemberManagementPage> {
  final members = <Map<String, String>>[
    {'name': 'Shrawan Prajapati', 'role': 'Head', 'dept': 'CSE 2026'},
    {'name': 'Rahul Sharma', 'role': 'Core', 'dept': 'CSE 2025'},
    {'name': 'Priya Singh', 'role': 'Member', 'dept': 'ECE 2026'},
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: ClubColors.background,
    appBar: AppBar(
      backgroundColor: ClubColors.background,
      elevation: 0,
      title: const Text(
        'Manage Members',
        style: TextStyle(
          color: ClubColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    body: members.isEmpty
        ? const Center(
            child: Text(
              'No club members found',
              style: TextStyle(color: ClubColors.textSecondary),
            ),
          )
        : ListView(
            padding: const EdgeInsets.all(20),
            children: members.map(_memberTile).toList(),
          ),
  );
  Widget _memberTile(Map<String, String> member) => Card(
    color: ClubColors.surface,
    margin: const EdgeInsets.only(bottom: 12),
    child: ListTile(
      leading: const CircleAvatar(
        backgroundColor: ClubColors.primary,
        child: Icon(Icons.person, color: ClubColors.textPrimary),
      ),
      title: Text(
        member['name']!,
        style: const TextStyle(
          color: ClubColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '${member['role']} · ${member['dept']}',
        style: const TextStyle(color: ClubColors.textSecondary),
      ),
      trailing: member['role'] == 'Head'
          ? null
          : IconButton(
              icon: const Icon(
                Icons.remove_circle_outline,
                color: ClubColors.textSecondary,
              ),
              onPressed: () {
                setState(() => members.remove(member));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${member['name']} removed from club.'),
                  ),
                );
              },
            ),
    ),
  );
}
