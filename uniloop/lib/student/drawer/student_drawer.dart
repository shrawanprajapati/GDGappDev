import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../council_clubs_page.dart';
import '../profile/profile_page.dart';
import '../projects/find_project_page.dart'; // 👈 Import perfect hai
import '../workspace/my_projects_page.dart';
import '../alumni/alumni_list_page.dart';

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
            // Header
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
                    Text('Shrawan Prajapati', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Student • CSE 2026', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.white12, thickness: 1),
            
            // 1. Profile
            _drawerItem(
              context, 
              Icons.person_outline, 
              'Profile', 
              onTap: () {
                Navigator.pop(context); 
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
              }
            ),
            
            // 2. Find Project (Syntax Fixed)
            _drawerItem(
              context, 
              Icons.work_outline, 
              'Find Project', 
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FindProjectPage()));
              }
            ),
            _drawerItem(
              context, 
              Icons.assignment_outlined, 
              'My Projects', 
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MyProjectsPage()));
              }
            ),
            _drawerItem(context, Icons.class_outlined, 'Reminder (classroom type)'),
            
            const Divider(color: Colors.white12, thickness: 1, height: 30),

            // 3. College Clubs
            _drawerHeader('Know your College clubs'),
            _buildCouncilItem(
              context, 'Technical Club', Icons.computer, Colors.blueAccent,
              [
                {'name': 'Programming Club', 'icon': Icons.code, 'desc': 'Competitive coding & dev.'},
                {'name': 'Robotics Club', 'icon': Icons.smart_toy, 'desc': 'Hardware & automation.'},
                {'name': 'Astronomy Club', 'icon': Icons.public, 'desc': 'Space & stargazing.'},
              ]
            ),
            _buildCouncilItem(
              context, 'Cultural Club', Icons.music_note, Colors.pinkAccent,
              [
                {'name': 'Music Club', 'icon': Icons.piano, 'desc': 'Singing & instruments.'},
                {'name': 'Dance Club', 'icon': Icons.directions_run, 'desc': 'Choreography & street dance.'},
                {'name': 'Drama Club', 'icon': Icons.theater_comedy, 'desc': 'Acting & theatre.'},
              ]
            ),
            _buildCouncilItem(
              context, 'Sports', Icons.sports_soccer, Colors.greenAccent,
              [
                {'name': 'Cricket Team', 'icon': Icons.sports_cricket, 'desc': 'Institute cricket team.'},
                {'name': 'Football Team', 'icon': Icons.sports_soccer, 'desc': 'Institute football team.'},
                {'name': 'Athletics Team', 'icon': Icons.directions_run, 'desc': 'Track & field events.'},
              ]
            ),
            _buildCouncilItem(
              context, 'Association', Icons.groups, Colors.orangeAccent,
              [
                {'name': 'Alumni Connect', 'icon': Icons.people, 'desc': 'Networking with alumni.'},
                {'name': 'Counselling Cell', 'icon': Icons.psychology, 'desc': 'Mental health support.'},
              ]
            ),

            const Divider(color: Colors.white12, thickness: 1, height: 30),

            // 4. Connect Alumni
            _drawerHeader('Connect Alumni'),
            _drawerItem(context, Icons.mic_none_outlined, 'Talks'),
            _drawerItem(
              context, 
              Icons.people_outline, 
              'Know our Alumni',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AlumniListPage()));
              }
            ),
            _drawerItem(context, Icons.handshake_outlined, 'Request for Guidance'),
            _drawerItem(context, Icons.work_history_outlined, 'Internship'),

            const Divider(color: Colors.white12, thickness: 1, height: 30),

            // 5. Placement
            _drawerHeader('Placement'),
            _drawerItem(context, Icons.business_outlined, 'Know different companies'),
            _drawerItem(context, Icons.school_outlined, 'Scholarship'),

            const Divider(color: Colors.white12, thickness: 1, height: 30),

            // 6. Others
            _drawerItem(context, Icons.storefront_outlined, 'UniLoop MarketPlace'),
            _drawerItem(context, Icons.settings_outlined, 'Settings'),
            _drawerItem(context, Icons.description_outlined, 'Terms and conditions'),
            
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
          Text(title, style: const TextStyle(color: AppColors.accent, fontSize: 16, fontWeight: FontWeight.bold)),
          const Icon(Icons.chevron_right, color: AppColors.accent, size: 20),
        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context, IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      leading: Icon(icon, color: AppColors.textSecondary, size: 22),
      title: Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 15)),
      onTap: onTap ?? () {}, 
    );
  }

  Widget _buildCouncilItem(
    BuildContext context, 
    String name, 
    IconData icon, 
    Color color,
    List<Map<String, dynamic>> clubs,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      leading: Icon(icon, color: color, size: 22),
      title: Text(name, style: const TextStyle(color: AppColors.textPrimary, fontSize: 15)),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CouncilClubsPage(
              councilName: name,
              clubs: clubs,
              themeColor: color,
            ),
          ),
        );
      },
    );
  }
}