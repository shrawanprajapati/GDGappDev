import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class AlumniTalksPage extends StatelessWidget {
  AlumniTalksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        title: Text(
          'Alumni Talks',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
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
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.mic, color: AppColors.accent),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            speaker,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          SizedBox(height: 4),
          Text(
            time,
            style: TextStyle(color: Colors.orangeAccent, fontSize: 12),
          ),
        ],
      ),
    );
  }
}


