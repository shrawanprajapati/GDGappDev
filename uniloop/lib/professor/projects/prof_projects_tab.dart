import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'create_project_page.dart';

class ProfProjectsTab extends StatelessWidget {
  ProfProjectsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Research Projects',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateProjectPage()),
              ),
              icon: Icon(Icons.add, size: 16),
              label: Text('New Project'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),

        _buildProjectCard(
          context,
          title: 'AI in Healthcare Research',
          stats: '3 Students Applied',
          isActive: true,
        ),
        _buildProjectCard(
          context,
          title: 'Quantum Computing Paper',
          stats: '1 Student Shortlisted',
          isActive: true,
        ),
      ],
    );
  }

  Widget _buildProjectCard(
    BuildContext context, {
    required String title,
    required String stats,
    required bool isActive,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive
              ? AppColors.accent.withValues(alpha: 0.3)
              : Colors.transparent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.more_vert, color: AppColors.textSecondary),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stats,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Show Applicants
                },
                child: Text(
                  'Review Applicants',
                  style: TextStyle(color: AppColors.accent, fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
