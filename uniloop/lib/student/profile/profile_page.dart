import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'edit_profile_page.dart'; 

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text('My Profile', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppColors.textPrimary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfilePage()),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header (Sirf View, koi line ya camera icon nahi)
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 3),
                      image: const DecorationImage(
                        image: NetworkImage('https://i.pravatar.cc/300?img=11'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Shrawan Prajapati', 
                    style: TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.w800)
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'B.Tech CSE • 2nd Year • IIT Indore', 
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 14)
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),

            // 2. Social Links
            Row(
              children: [
                Expanded(child: _buildLinkCard(Icons.code, 'GitHub', Colors.white)),
                const SizedBox(width: 12),
                Expanded(child: _buildLinkCard(Icons.work, 'LinkedIn', Colors.blueAccent)),
              ],
            ),

            const SizedBox(height: 30),

            // 3. Clubs & Councils
            const Text('Clubs & Councils', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                _TagChip(label: 'Programming Club', color: Colors.blueAccent),
                _TagChip(label: 'GDG Core Team', color: Colors.orangeAccent),
                _TagChip(label: 'SnT Council', color: Colors.purpleAccent),
              ],
            ),

            const SizedBox(height: 30),

            // 4. Skills
            const Text('Skills', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                _TagChip(label: 'Flutter', color: AppColors.primary),
                _TagChip(label: 'Dart', color: AppColors.primary),
                _TagChip(label: 'Python', color: AppColors.primary),
                _TagChip(label: 'UI/UX Design', color: AppColors.primary),
              ],
            ),

            const SizedBox(height: 30),

            // 5. Interests
            const Text('Interests & Preferences', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Looking for:', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  SizedBox(height: 8),
                  _InterestItem(text: 'Internship (Summer 2025)'),
                  SizedBox(height: 6),
                  _InterestItem(text: 'Open Source Projects'),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 6. Resume
            const Text('Resume', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.picture_as_pdf, color: AppColors.primary, size: 30),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Shrawan_Resume.pdf', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                        SizedBox(height: 4),
                        Text('Uploaded • 2 days ago', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.upload_file, color: AppColors.accent),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkCard(IconData icon, String title, Color color) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  final Color color;
  const _TagChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w500)),
    );
  }
}

class _InterestItem extends StatelessWidget {
  final String text;
  const _InterestItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: AppColors.accent, size: 16),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: AppColors.textPrimary, fontSize: 14)),
      ],
    );
  }
}