import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'workspace_page.dart';

class MyProjectsPage extends StatelessWidget {
  MyProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Projects jisme student part hai
    final myProjects = [
      {
        'title': 'GDG Recruitment Task: Build a Portfolio',
        'role': 'Team Member',
        'status': 'In Progress',
        'progress': 0.6, // 60% done
        'deadline': '2 Days Left',
        'color': Colors.deepPurpleAccent,
        'teamSize': 4,
      },
      {
        'title': 'Campus Navigation App',
        'role': 'Flutter Developer',
        'status': 'Review Pending',
        'progress': 0.9, // 90% done
        'deadline': 'Completed',
        'color': AppColors.accent,
        'teamSize': 3,
      },
      {
        'title': 'AI Chatbot for Students',
        'role': 'AI Engineer',
        'status': 'Rejected', // Example of rejected application
        'progress': 0.0,
        'deadline': '-',
        'color': Colors.grey,
        'teamSize': 0,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        title: Text(
          'My Projects',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: myProjects.length,
        itemBuilder: (context, index) {
          final project = myProjects[index];
          return _buildProjectCard(context, project);
        },
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project) {
    bool isRejected = project['status'] == 'Rejected';

    return GestureDetector(
      onTap: () {
        if (!isRejected) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkspacePage(projectData: project),
            ),
          );
        }
      },
      child: Opacity(
        opacity: isRejected ? 0.5 : 1.0,
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.08)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: project['color'].withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      project['role'],
                      style: TextStyle(
                        color: project['color'],
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    project['status'],
                    style: TextStyle(
                      color: isRejected
                          ? Colors.redAccent
                          : (project['status'] == 'In Progress'
                                ? Colors.orangeAccent
                                : AppColors.accent),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                project['title'],
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16),

              if (!isRejected) ...[
                // Progress Bar
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: project['progress'],
                          backgroundColor: AppColors.background,
                          color: project['color'],
                          minHeight: 8,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      '${(project['progress'] * 100).toInt()}%',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Team of ${project['teamSize']}',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      project['deadline'],
                      style: TextStyle(
                        color: project['deadline'] == 'Completed'
                            ? AppColors.accent
                            : Colors.orangeAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Text(
                  'Your application was not shortlisted.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}


