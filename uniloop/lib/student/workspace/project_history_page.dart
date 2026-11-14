import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class ProjectHistoryPage extends StatelessWidget {
  ProjectHistoryPage({super.key, required this.projectTitle});
  final String projectTitle;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    appBar: AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      title: Text(
        'Project History',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    body: ListView(
      padding: EdgeInsets.all(20),
      children: [
        Text(
          projectTitle,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        _event(
          Icons.flag_outlined,
          'Project posted',
          'Opportunity published by the client',
        ),
        _event(
          Icons.groups_outlined,
          'Team joined',
          'Your team started working on the project',
        ),
        _event(
          Icons.upload_file_outlined,
          'Milestone submitted',
          'UI/UX Prototype Submission sent for review',
        ),
        _event(
          Icons.verified_outlined,
          'Milestone approved',
          'Client feedback and rating received',
        ),
      ],
    ),
  );
  Widget _event(IconData icon, String title, String detail) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: CircleAvatar(
      backgroundColor: AppColors.primary,
      child: Icon(icon, color: AppColors.textPrimary),
    ),
    title: Text(
      title,
      style: TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    ),
    subtitle: Text(detail, style: TextStyle(color: AppColors.textSecondary)),
  );
}
