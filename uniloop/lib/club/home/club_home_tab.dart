import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../events/create_event_page.dart';

class ClubHomeTab extends StatelessWidget {
  const ClubHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Welcome back, GDG Club', style: TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildStatCard('Active Events', '3', AppColors.primary),
              const SizedBox(width: 12),
              _buildStatCard('Applications', '145', AppColors.accent),
            ],
          ),
          const SizedBox(height: 30),
          const Text('Recent Activity', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildActivityCard('Rahul applied for GDG Induction', '2 hours ago'),
          _buildActivityCard('Tech Fest 2024 registration started', '1 day ago'),
          const SizedBox(height: 30),
          const Text('Quick Actions', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildActionButton(context, 'Post New Event / Induction', Icons.add_box_outlined, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateEventPage()));
          }),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withValues(alpha: 0.3))),
        child: Column(children: [
          Text(value, style: TextStyle(color: color, fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        ]),
      ),
    );
  }

  Widget _buildActivityCard(String text, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        const Icon(Icons.notifications_active, color: AppColors.accent, size: 20),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(color: AppColors.textPrimary, fontSize: 14))),
        Text(time, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      ]),
    );
  }

  Widget _buildActionButton(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Icon(icon, color: AppColors.accent),
          const SizedBox(width: 16),
          Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, color: AppColors.textSecondary, size: 16),
        ]),
      ),
    );
  }
}