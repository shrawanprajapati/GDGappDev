import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'project_details_page.dart';

class ProjectListPage extends StatelessWidget {
  final String category;
  ProjectListPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final allProjects = [
      // --- INDUSTRIAL PROJECTS ---
      {
        'title': 'Campus Navigation App',
        'postedBy': 'TechCorp India',
        'desc': 'Need a Flutter app for indoor navigation in colleges.',
        'skills': ['Flutter', 'Google Maps API'],
        'budget': '₹15,000',
        'duration': '1 Month',
        'type': 'Industrial',
        'status': 'Open',
      },
      {
        'title': 'AI Chatbot for Students',
        'postedBy': 'EduTech Solutions',
        'desc': 'Build a custom GPT bot to answer admission queries.',
        'skills': ['Python', 'OpenAI API', 'NLP'],
        'budget': '₹25,000',
        'duration': '2 Months',
        'type': 'Industrial',
        'status': 'Open',
      },

      // --- INDUCTION PROJECTS ---
      {
        'title': 'GDG Recruitment Task: Build a Portfolio',
        'postedBy': 'Google Developer Groups (GDG)',
        'desc':
            'Build a responsive personal portfolio website to get inducted into the Web Dev team.',
        'skills': ['HTML/CSS', 'JavaScript', 'React'],
        'budget': 'Induction Task',
        'duration': '1 Week',
        'type': 'Induction',
        'status': 'Urgent',
      },
      {
        'title': 'Programming Club Induction: CP Contest',
        'postedBy': 'Programming Club (P Club)',
        'desc':
            'Participate in the competitive coding contest and solve at least 4 problems to get shortlisted.',
        'skills': ['C++', 'Data Structures'],
        'budget': 'Induction Task',
        'duration': '3 Hours',
        'type': 'Induction',
        'status': 'Open',
      },
      {
        'title': 'Robotics Cell Induction: Line Follower Bot',
        'postedBy': 'Robotics Cell',
        'desc':
            'Build a basic line follower robot and submit a video demonstration of it working.',
        'skills': ['Arduino', 'Embedded C'],
        'budget': 'Induction Task',
        'duration': '2 Weeks',
        'type': 'Induction',
        'status': 'Open',
      },

      // --- PROFESSOR PROJECTS ---
      {
        'title': 'Research on Quantum Computing',
        'postedBy': 'Dr. A. Sharma (CSE Dept)',
        'desc': 'Looking for 2 students to assist in a research paper.',
        'skills': ['Python', 'Maths', 'Research'],
        'budget': 'Academic Credit',
        'duration': '3 Months',
        'type': 'Professor',
        'status': 'Open',
      },
    ];

    final filteredProjects = allProjects
        .where((p) => p['type'] == category)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        title: Text(
          category,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: filteredProjects.isEmpty
          ? Center(
              child: Text(
                "No projects found.",
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: filteredProjects.length,
              itemBuilder: (context, index) {
                final project = filteredProjects[index];
                return _buildProjectCard(context, project);
              },
            ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project) {
    Color typeColor;
    if (project['type'] == 'Induction') {
      typeColor = Colors.deepPurpleAccent;
    } else if (project['type'] == 'Industrial') {
      typeColor = AppColors.accent;
    } else {
      typeColor = Colors.orangeAccent;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectDetailsPage(projectData: project),
          ),
        );
      },
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
                    color: typeColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    project['type'].toUpperCase(),
                    style: TextStyle(
                      color: typeColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (project['status'] == 'Urgent')
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Urgent',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
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
            SizedBox(height: 6),

            Row(
              children: [
                Icon(Icons.business, size: 14, color: AppColors.textSecondary),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    project['postedBy'],
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (project['skills'] as List<String>)
                  .map(
                    (skill) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.textPrimary.withValues(alpha: 0.08),
                        ),
                      ),
                      child: Text(
                        skill,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${project['budget']} • ${project['duration']}',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'View Details',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


