import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class ClubProjectsTab extends StatelessWidget {
  const ClubProjectsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Club Projects', style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
            ElevatedButton.icon(
              onPressed: () => _showCreateProjectDialog(context),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('New Project'),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
            )
          ],
        ),
        const SizedBox(height: 20),

        _buildProjectCard(
          context,
          title: 'GDG Recruitment Task 2024',
          type: 'Induction Project',
          stats: '85 Applied • 4 Shortlisted',
          isActive: true,
        ),
        _buildProjectCard(
          context,
          title: 'Campus Navigation App',
          type: 'Industrial Project',
          stats: '12 Applied • In Progress',
          isActive: true,
        ),
        
        const SizedBox(height: 10),
        const Text('Completed Projects', style: TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _buildProjectCard(
          context,
          title: 'Smart India Hackathon Prototype',
          type: 'Competition',
          stats: 'Completed',
          isActive: false,
        ),
      ],
    );
  }

  Widget _buildProjectCard(BuildContext context, {required String title, required String type, required String stats, required bool isActive}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface, 
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isActive ? AppColors.primary.withValues(alpha: 0.3) : Colors.transparent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4)),
                child: Text(type, style: const TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              if (isActive)
                const Icon(Icons.more_vert, color: AppColors.textSecondary)
            ],
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(stats, style: TextStyle(color: isActive ? AppColors.accent : AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.bold)),
              if (isActive)
                TextButton(
                  onPressed: () {
                    // Applicants view
                  },
                  child: const Text('View Applicants', style: TextStyle(color: AppColors.primary, fontSize: 12)),
                )
            ],
          )
        ],
      ),
    );
  }

  void _showCreateProjectDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Post New Project', style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildInputField('Project Title'),
              const SizedBox(height: 12),
              _buildInputField('Required Skills (comma separated)'),
              const SizedBox(height: 12),
              _buildInputField('Description', maxLines: 3),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Project Posted!'), backgroundColor: AppColors.accent),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: const Text('Post Project', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInputField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}