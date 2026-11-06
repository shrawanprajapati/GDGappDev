import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'student_events_page.dart';
import 'projects/find_project_page.dart'; // 👈 Import

class StudentHomeTab extends StatelessWidget {
  const StudentHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome to UniLoop',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 30),

          // 1. Ongoing Inductions
          _buildSectionTitle('Ongoing inductions'),
          const SizedBox(height: 12),
          _buildInductionCard(context),

          const SizedBox(height: 30),

          // 2. Trending on Campus
          _buildSectionTitle('Trending On Campus'),
          const SizedBox(height: 12),
          _buildHorizontalTiles(context, isEvent: false),

          const SizedBox(height: 30),

          // 3. Events
          _buildSectionTitle('Events'),
          const SizedBox(height: 12),
          _buildHorizontalTiles(context, isEvent: true),

          const SizedBox(height: 30),

          // 4. Recommendation
          _buildSectionTitle('Recommendation for you'),
          const SizedBox(height: 8),
          Text(
            'Based on the skills you got, here are project recommendations.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 12),
          _buildRecommendationCard(context),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  // --- INDUCTION CARD (Connected to Projects) ---
  Widget _buildInductionCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Find Project (Induction)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FindProjectPage()),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'IIT BHU Induction',
                    style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Click to explore\ninduction projects',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  // --- HORIZONTAL TILES (Trending & Events) ---
  Widget _buildHorizontalTiles(BuildContext context, {bool isEvent = false}) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (isEvent) {
                // Navigate to Events Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StudentEventsPage()),
                );
              } else {
                // TODO: Navigate to Trending Post Details
              }
            },
            child: Container(
              width: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    isEvent ? Icons.event : Icons.local_fire_department,
                    color: isEvent ? AppColors.accent : AppColors.primary,
                    size: 28,
                  ),
                  const Spacer(),
                  Text(
                    isEvent ? 'Tech Fest 2024' : 'Hackathon Winners',
                    style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isEvent ? 'Oct 24 • Main Audi' : 'Trending #1',
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // --- RECOMMENDATION CARD ---
  Widget _buildRecommendationCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Projects Marketplace
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FindProjectPage()),
        );
      },
      child: Container(
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
              decoration: const BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.lightbulb_outline, color: AppColors.accent),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Project: Smart Campus',
                    style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Matches your Python & ML skills',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}