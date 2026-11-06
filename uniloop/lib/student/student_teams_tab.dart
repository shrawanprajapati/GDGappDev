import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class StudentTeamsTab extends StatelessWidget {
  const StudentTeamsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Project Teams',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Open Create Team Dialog
                },
                icon: const Icon(Icons.add, size: 18, color: Colors.white),
                label: const Text('Create'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Join a team for upcoming projects like Vishwakarma Award, or build your own.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
          
          const SizedBox(height: 30),

          // 1. My Teams Section
          const Text(
            'My Teams',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          
          // Card for a Team user created
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Vishwakarma Award Team',
                      style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    // Delete option for Team Leader
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                      onPressed: () {
                        // TODO: Delete team logic
                      },
                    )
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Status: 3/4 Members • Leader',
                  style: TextStyle(color: AppColors.accent, fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                // Department and Year tags
                Row(
                  children: [
                    _buildTag('CSE'),
                    const SizedBox(width: 8),
                    _buildTag('2nd Year'),
                  ],
                )
              ],
            ),
          ),

          const SizedBox(height: 30),

          // 2. Discover Teams Section
          const Text(
            'Discover Teams',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),

          // Filters (Department, Year)
          Row(
            children: [
              _buildFilterChip('All Depts', isSelected: true),
              const SizedBox(width: 8),
              _buildFilterChip('CSE'),
              const SizedBox(width: 8),
              _buildFilterChip('Mech'),
            ],
          ),
          const SizedBox(height: 16),

          // List of teams looking for members
          _buildTeamDiscoverCard(
            title: 'Hackathon Squad',
            project: 'Smart India Hackathon',
            members: '2/4 Members',
            tags: ['ECE', '3rd Year'],
          ),
          const SizedBox(height: 12),
          _buildTeamDiscoverCard(
            title: 'Design Innovators',
            project: 'Vishwakarma Award',
            members: '3/4 Members',
            tags: ['Design', '1st Year'],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
    );
  }

  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary.withValues(alpha: 0.2) : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? AppColors.primary : Colors.white.withValues(alpha: 0.05)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTeamDiscoverCard({
    required String title,
    required String project,
    required String members,
    required List<String> tags,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text('Project: $project', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.people, size: 14, color: AppColors.accent),
                  const SizedBox(width: 4),
                  Text(members, style: const TextStyle(color: AppColors.accent, fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 12),
                  ...tags.map((t) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: _buildTag(t),
                  )),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.background,
              foregroundColor: AppColors.textPrimary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
            child: const Text('Join'),
          )
        ],
      ),
    );
  }
}