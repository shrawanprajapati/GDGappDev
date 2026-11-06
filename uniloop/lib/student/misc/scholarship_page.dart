import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class ScholarshipPage extends StatelessWidget {
  const ScholarshipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text('Scholarships', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildScholarshipCard('Merit-cum-Means Scholarship', 'For top 10% students', 'Deadline: Nov 30'),
          _buildScholarshipCard('Google Generation Scholarship', 'For CS students', 'Deadline: Dec 15'),
          _buildScholarshipCard('Reliance Foundation Scholarship', 'For all UG students', 'Deadline: Jan 10'),
        ],
      ),
    );
  }

  Widget _buildScholarshipCard(String title, String desc, String deadline) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          const Icon(Icons.school, color: Colors.orangeAccent, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 15, fontWeight: FontWeight.bold)),
                Text(desc, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                const SizedBox(height: 4),
                Text(deadline, style: const TextStyle(color: Colors.redAccent, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}