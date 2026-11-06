import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'club_detail_page.dart'; // 👈 Import add karo

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

            // 2. College Clubs (Updated with navigation)
            _drawerHeader('Know your College clubs'),
            _buildClubItem(context, 'Technical Club', Icons.computer, Colors.blueAccent),
            _buildClubItem(context, 'Cultural Club', Icons.music_note, Colors.pinkAccent),
            _buildClubItem(context, 'Sports', Icons.sports_soccer, Colors.greenAccent),
            _buildClubItem(context, 'Association', Icons.groups, Colors.orangeAccent),

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
      onTap: () {},
    );
  }

  // 👈 Naya function jo clubs ko ClubDetailPage se connect karega
  Widget _buildClubItem(BuildContext context, String name, IconData icon, Color color) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      leading: Icon(icon, color: color, size: 22),
      title: Text(
        name,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 15),
      ),
      onTap: () {
        // Drawer close karo
        Navigator.pop(context); 
        
        // Fir ClubDetailPage open karo
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClubDetailPage(
              clubData: {
                'name': name,
                'category': 'Club',
                'members': 'Active Members',
                'icon': icon,
                'color': color,
              },
            ),
          ),
        );
      },
    );
  }
}