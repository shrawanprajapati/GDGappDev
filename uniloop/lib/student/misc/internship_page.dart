import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class InternshipPage extends StatelessWidget {
  const InternshipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text('Internships', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildInternshipCard('Software Engineer Intern', 'Google', 'Stipend: ₹80k/month'),
          _buildInternshipCard('Data Analyst Intern', 'Amazon', 'Stipend: ₹60k/month'),
          _buildInternshipCard('Product Design Intern', 'Zomato', 'Stipend: ₹40k/month'),
        ],
      ),
    );
  }

  Widget _buildInternshipCard(String role, String company, String stipend) {
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.15), shape: BoxShape.circle),
            child: const Icon(Icons.work, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(role, style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
                Text(company, style: const TextStyle(color: AppColors.accent, fontSize: 13)),
                const SizedBox(height: 4),
                Text(stipend, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.surface, foregroundColor: AppColors.textPrimary),
            child: const Text('Apply'),
          )
        ],
      ),
    );
  }
}