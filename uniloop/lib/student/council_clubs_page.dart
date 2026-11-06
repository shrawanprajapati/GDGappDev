import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'club_detail_page.dart';

class CouncilClubsPage extends StatelessWidget {
  final String councilName;
  final List<Map<String, dynamic>> clubs;
  final Color themeColor;

  const CouncilClubsPage({
    super.key,
    required this.councilName,
    required this.clubs,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Text(
          councilName,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: clubs.length,
        itemBuilder: (context, index) {
          final club = clubs[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: themeColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(club['icon'], color: themeColor, size: 24),
              ),
              title: Text(
                club['name'],
                style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                club['desc'] ?? 'Explore events and projects',
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
              trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              onTap: () {
                // Direct Club Detail Page par le jao
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClubDetailPage(
                      clubData: {
                        'name': club['name'],
                        'category': councilName,
                        'members': 'Active Members',
                        'icon': club['icon'],
                        'color': themeColor,
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}