import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class AlumniTalksPage extends StatelessWidget {
  const AlumniTalksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text(
          'Alumni Talks',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildTalkCard(
            'How to crack FAANG interviews',
            'Rahul Sharma (Google)',
            'Oct 25, 5:00 PM',
          ),
          _buildTalkCard(
            'Transitioning from College to Corporate',
            'Priya Singh (Microsoft)',
            'Nov 02, 6:00 PM',
          ),
          _buildTalkCard(
            'Research vs Industry Careers',
            'Dr. Amit Patel',
            'Nov 10, 4:00 PM',
          ),
        ],
      ),
    );
  }

  Widget _buildTalkCard(String title, String speaker, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.mic, color: AppColors.accent),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            speaker,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(color: Colors.orangeAccent, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
