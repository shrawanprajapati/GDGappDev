import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'create_team_sheet.dart'; // 👈 Import add kiya
import 'team_profile.dart';
import '../../core/data/mock_store.dart';

class StudentTeamsTab extends StatefulWidget {
  StudentTeamsTab({super.key});

  @override
  State<StudentTeamsTab> createState() => _StudentTeamsTabState();
}

class _StudentTeamsTabState extends State<StudentTeamsTab> {
  // Student ki profile (Dummy data - backend aane par dynamic hoga)
  final List<String> studentSkills = ['Flutter', 'Dart', 'UI/UX Design'];
  final String studentDept = 'CSE';
  final String studentYear = '2nd Year';

  final List<Map<String, dynamic>> allTeams = [
    {
      'name': 'Hackathon Squad',
      'project': 'Smart India Hackathon',
      'members': '2/4',
      'skills': ['Python', 'Machine Learning', 'Flutter'],
      'dept': 'CSE',
      'year': '3rd Year',
    },
    {
      'name': 'Design Innovators',
      'project': 'Vishwakarma Award',
      'members': '3/4',
      'skills': ['Figma', 'UI/UX Design', 'Flutter'],
      'dept': 'Any',
      'year': '2nd Year',
    },
    {
      'name': 'Robo Warriors',
      'project': 'Robotics Competition',
      'members': '1/4',
      'skills': ['C++', 'Arduino', 'Hardware'],
      'dept': 'Mech',
      'year': '4th Year',
    },
    {
      'name': 'FullStack Ninjas',
      'project': 'College Portal',
      'members': '2/4',
      'skills': ['React', 'Node.js', 'MongoDB'],
      'dept': 'CSE',
      'year': '3rd Year',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final recommendedTeams = allTeams.where((team) {
      final skills = List<String>.from(team['skills']);
      return skills.any((skill) => studentSkills.contains(skill));
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Project Teams',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // 👈 Bottom Sheet call kiya
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: AppColors.surface,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    builder: (context) => CreateTeamSheet(),
                  );
                },
                icon: Icon(Icons.add, size: 18, color: Colors.white),
                label: Text('Create'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Find teams matching your skills, or build your own.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),

          SizedBox(height: 30),

          // 1. My Teams Section
          Text(
            'My Teams',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12),

          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Vishwakarma Award Team',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: _showInviteDialog,
                          icon: Icon(Icons.person_add_alt_1, size: 16),
                          label: Text('Invite'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.accent,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Status: 3/4 Members • You are Leader',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    _buildTag(studentDept),
                    SizedBox(width: 8),
                    _buildTag(studentYear),
                  ],
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TeamProfilePage()),
                    ),
                    icon: Icon(Icons.groups_outlined),
                    label: Text('View Team Profile'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.accent,
                      side: BorderSide(color: AppColors.accent),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 30),

          // 2. Discover Teams
          Text(
            'Recommended Teams (Skill Match)',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Teams looking for members with your skills.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          SizedBox(height: 16),

          if (recommendedTeams.isEmpty)
            Center(
              child: Text(
                "No matching teams found right now.",
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          else
            ...recommendedTeams.map(
              (team) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: _buildTeamDiscoverCard(
                  title: team['name'],
                  project: team['project'],
                  members: '${team['members']} Members',
                  skills: List<String>.from(team['skills']),
                  tags: [team['dept'], team['year']],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
      ),
    );
  }

  void _showInviteDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Invite Student',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: TextField(
          controller: controller,
          style: TextStyle(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: 'student@university.edu',
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
              final invited = MockStore.instance.users.firstWhere(
                (user) => user['email'] == controller.text.trim(),
                orElse: () => {'id': 'student-2'},
              );
              MockStore.instance.addNotification(
                userId: invited['id'],
                type: 'Teams',
                text: 'You have been invited to join Vishwakarma Award Team.',
                route: '/student-dashboard',
              );
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Invite sent to ${controller.text.trim()}'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textPrimary,
            ),
            child: Text('Send Invite'),
          ),
        ],
      ),
    ).whenComplete(controller.dispose);
  }

  Widget _buildTeamDiscoverCard({
    required String title,
    required String project,
    required String members,
    required List<String> skills,
    required List<String> tags,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Project: $project',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 8),

                Row(
                  children: [
                    Icon(Icons.people, size: 14, color: AppColors.accent),
                    SizedBox(width: 4),
                    Text(
                      members,
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 12),
                    ...tags.map(
                      (t) => Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: _buildTag(t),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),

                Wrap(
                  spacing: 6,
                  children: skills.map((skill) {
                    final isMatch = studentSkills.contains(skill);
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isMatch
                            ? AppColors.accent.withValues(alpha: 0.15)
                            : AppColors.background,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: isMatch
                              ? AppColors.accent.withValues(alpha: 0.5)
                              : Colors.transparent,
                        ),
                      ),
                      child: Text(
                        skill,
                        style: TextStyle(
                          color: isMatch
                              ? AppColors.accent
                              : AppColors.textSecondary,
                          fontSize: 11,
                          fontWeight: isMatch
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
            child: Text('Join'),
          ),
        ],
      ),
    );
  }
}


