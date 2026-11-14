import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/data/mock_store.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        title: Text(
          'My Profile',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_outlined, color: AppColors.textPrimary),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfilePage()),
            ),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: MockStore.instance,
        builder: (context, child) {
          final student = MockStore.instance.currentUser;

          if (student == null) {
            return Center(
              child: Text(
                'No user logged in',
                style: TextStyle(color: AppColors.textPrimary),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                // 1. HEADER SECTION
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary,
                            width: 3,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://i.pravatar.cc/300?img=11',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        student['name'] ?? 'Student Name',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        student['bio'] ?? '',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),

                      SizedBox(height: 16),

                      // Social Links
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialLink(
                            student['github'],
                            'GitHub',
                            Icons.code,
                          ),
                          SizedBox(width: 20),
                          _buildSocialLink(
                            student['linkedin'],
                            'LinkedIn',
                            Icons.work,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // 2. ABOUT ME
                _buildSectionHeader('About Me'),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    student['about'] ?? 'No bio added yet.',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // 3. SKILLS
                if ((student['skills'] as List? ?? []).isNotEmpty) ...[
                  _buildSectionHeader('Skills'),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: (student['skills'] as List).length,
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                      itemBuilder: (context, index) => _TagChip(
                        label: student['skills'][index],
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],

                // 4. PROJECTS
                if ((student['projects'] as List? ?? []).isNotEmpty) ...[
                  _buildSectionHeader('Projects & Experience'),
                  SizedBox(
                    height: 150,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: (student['projects'] as List).length,
                      separatorBuilder: (context, index) => SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final project = student['projects'][index];
                        return _buildHorizontalProjectCard(project);
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                ],

                // 5. CLUBS
                if ((student['clubs'] as List? ?? []).isNotEmpty) ...[
                  _buildSectionHeader('Clubs & Councils'),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: (student['clubs'] as List).length,
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                      itemBuilder: (context, index) => _TagChip(
                        label: student['clubs'][index],
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],

                // 6. ACHIEVEMENTS
                if ((student['achievements'] as List? ?? []).isNotEmpty) ...[
                  _buildSectionHeader('Achievements'),
                  SizedBox(
                    height: 110,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: (student['achievements'] as List).length,
                      separatorBuilder: (context, index) => SizedBox(width: 12),
                      itemBuilder: (context, index) =>
                          _buildHorizontalAchievementCard(
                            student['achievements'][index],
                          ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],

                // 7. INTERESTS
                if ((student['interests'] as List? ?? []).isNotEmpty) ...[
                  _buildSectionHeader('Interests & Preferences'),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: (student['interests'] as List).length,
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.accent.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: AppColors.accent,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                student['interests'][index],
                                style: TextStyle(
                                  color: AppColors.accent,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                ],

                // 8. RESUME
                _buildSectionHeader('Resume'),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.picture_as_pdf,
                            color: AppColors.primary,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student['resumeName'] ?? 'Resume.pdf',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Uploaded • Just now',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.upload_file_outlined,
                            color: AppColors.accent,
                          ),
                          onPressed: () => _showResumeDialog(context),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSocialLink(String? url, String platform, IconData icon) {
    bool isAdded = url != null && url.isNotEmpty;
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(
            isAdded ? icon : Icons.add_link,
            size: 18,
            color: isAdded ? AppColors.accent : AppColors.textSecondary,
          ),
          SizedBox(width: 6),
          Text(
            isAdded ? url : 'Add $platform',
            style: TextStyle(
              color: isAdded ? AppColors.accent : AppColors.textSecondary,
              fontSize: 14,
              fontWeight: isAdded ? FontWeight.w600 : FontWeight.normal,
              decoration: isAdded ? TextDecoration.underline : null,
              decorationColor: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }

  void _showResumeDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Add Resume',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: TextField(
          controller: controller,
          style: TextStyle(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: 'Resume file name or link',
            hintStyle: TextStyle(color: AppColors.textSecondary),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isEmpty) return;
              MockStore.instance.updateCurrentUser({
                'resumeName': controller.text.trim(),
              });
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Resume added to your profile.')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textPrimary,
            ),
            child: Text('Save Resume'),
          ),
        ],
      ),
    ).whenComplete(controller.dispose);
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildHorizontalProjectCard(dynamic project) {
    return Container(
      width: 250,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project['title'] ?? '',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            project['desc'] ?? '',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Spacer(),
          Text(
            'Tech: ${project['tech'] ?? ''}',
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalAchievementCard(String title) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.emoji_events, color: Colors.amber, size: 24),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  final Color color;
  _TagChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}


