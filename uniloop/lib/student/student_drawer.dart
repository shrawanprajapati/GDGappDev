import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class StudentDrawer extends StatelessWidget {
  const StudentDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          children: [
            // Header (Profile Info)
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.person, size: 30, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Shrawan Prajapati',
                      style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Student • CSE 2026',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.white12, thickness: 1),
            
            // 1. Profile & Reminders
            _drawerItem(Icons.person_outline, 'Profile'),
            _drawerItem(Icons.work_outline, 'Find Project'),
            _drawerItem(Icons.class_outlined, 'Reminder (classroom type)'),
            
            const Divider(color: Colors.white12, thickness: 1, height: 30),

            // 2. College Clubs
            _drawerHeader('Know your College clubs'),
            _drawerItem(Icons.computer, 'Technical Club'),
            _drawerItem(Icons.music_note_outlined, 'Cultural Club'),
            _drawerItem(Icons.sports_cricket_outlined, 'Sports'),
            _drawerItem(Icons.group_outlined, 'Association'),

            const Divider(color: Colors.white12, thickness: 1, height: 30),

            // 3. Connect Alumni
            _drawerHeader('Connect Alumni'),
            _drawerItem(Icons.mic_none_outlined, 'Talks'),
            _drawerItem(Icons.people_outline, 'Know our Alumni'),
            _drawerItem(Icons.handshake_outlined, 'Request for Guidance'),
            _drawerItem(Icons.work_history_outlined, 'Internship'),

            const Divider(color: Colors.white12, thickness: 1, height: 30),

            // 4. Placement
            _drawerHeader('Placement'),
            _drawerItem(Icons.business_outlined, 'Know different companies'),
            _drawerItem(Icons.school_outlined, 'Scholarship'),

            const Divider(color: Colors.white12, thickness: 1, height: 30),

            // 5. General
            _drawerItem(Icons.storefront_outlined, 'UniLoop MarketPlace'),
            _drawerItem(Icons.settings_outlined, 'Settings'),
            _drawerItem(Icons.description_outlined, 'Terms and conditions'),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _drawerHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.accent, 
              fontSize: 16, 
              fontWeight: FontWeight.bold
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.accent, size: 20),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      leading: Icon(icon, color: AppColors.textSecondary, size: 22),
      title: Text(
        title,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 15),
      ),
      onTap: () {
        // TODO: Navigate to respective pages
      },
    );
  }
}