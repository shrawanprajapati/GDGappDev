import 'package:flutter/material.dart';
import '../../core/app_colors.dart'; // (Kyunki core bahar hai student folder se)
import '../../core/app_theme.dart';
import '../events/student_events_page.dart'; // 👈 Ye line change karo (student folder se direct)
import '../projects/find_project_page.dart'; // 👈 Ye line change karo (student folder se direct)
import '../../core/data/mock_store.dart';

class StudentHomeTab extends StatelessWidget {
  StudentHomeTab({super.key});

  // 👈 1. Time ke hisaab se Greeting nikalne ka function
  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppTheme.settings,
      builder: (context, _) {
        AppTheme.syncCurrentColors();
        final studentName =
            (MockStore.instance.currentUser?['name'] ?? 'Student')
                .toString()
                .split(' ')
                .first;
        return ListenableBuilder(
          listenable: MockStore.instance,
          builder: (context, _) => SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 3. Dynamic Greeting & Name
                Text(
                  '${_getGreeting()}, $studentName 👋',
                  style: TextStyle(
                    fontSize: 26, // Font size thoda adjust kiya
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'What are you looking to build today?',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 30),

                // 1. Ongoing Inductions
                _buildSectionTitle('Ongoing inductions'),
                SizedBox(height: 12),
                _buildInductionCard(context),

                SizedBox(height: 30),

                // 2. Trending on Campus
                _buildSectionTitle('Trending On Campus'),
                SizedBox(height: 12),
                _buildHorizontalTiles(context, isEvent: false),

                SizedBox(height: 30),

                // 3. Events
                _buildSectionTitle('Events'),
                SizedBox(height: 12),
                _buildHorizontalTiles(context, isEvent: true),

                SizedBox(height: 30),

                // 4. Recommendation
                _buildSectionTitle('Recommendation for you'),
                SizedBox(height: 8),
                Text(
                  'Based on the skills you got, here are project recommendations.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 12),
                _buildRecommendationCard(context),

                SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildInductionCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FindProjectPage()),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: Offset(0, 10),
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'IIT BHU Induction',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Click to explore\ninduction projects',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_forward, color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalTiles(BuildContext context, {bool isEvent = false}) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (context, index) => SizedBox(width: 16),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (isEvent) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentEventsPage()),
                );
              }
            },
            child: Container(
              width: 200,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.textPrimary.withValues(alpha: 0.08),
                ),
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
                  Spacer(),
                  Text(
                    isEvent ? 'Tech Fest 2024' : 'Hackathon Winners',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    isEvent ? 'Oct 24 • Main Audi' : 'Trending #1',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecommendationCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FindProjectPage()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.textPrimary.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.lightbulb_outline, color: AppColors.accent),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Project: Smart Campus',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Matches your Python & ML skills',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
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
