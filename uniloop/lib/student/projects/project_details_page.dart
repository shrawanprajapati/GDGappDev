import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/data/mock_store.dart';
import '../../core/session_service.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Map<String, dynamic> projectData;
  ProjectDetailsPage({super.key, required this.projectData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              projectData['type'].toUpperCase(),
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              projectData['title'],
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Posted by ${projectData['postedBy']}',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),

            SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoBox(
                  'Budget',
                  projectData['budget'],
                  Icons.currency_rupee,
                ),
                _buildInfoBox(
                  'Duration',
                  projectData['duration'],
                  Icons.timer_outlined,
                ),
                _buildInfoBox(
                  'Status',
                  projectData['status'],
                  Icons.circle,
                  color: AppColors.accent,
                ),
              ],
            ),

            SizedBox(height: 30),

            Text(
              'Project Description',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              projectData['desc'],
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 15,
                height: 1.5,
              ),
            ),

            SizedBox(height: 24),
            Text(
              'Expected Deliverables',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Working prototype, source code, documentation, and a short demo presentation.',
              style: TextStyle(color: AppColors.textSecondary, height: 1.5),
            ),

            SizedBox(height: 24),
            Text(
              'Timeline',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              projectData['duration'],
              style: TextStyle(color: AppColors.textSecondary),
            ),

            SizedBox(height: 30),

            Text(
              'Required Skills',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: (projectData['skills'] as List<String>)
                  .map(
                    (skill) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        skill,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),

            SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  _showApplyDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Apply for this Project',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox(
    String label,
    String value,
    IconData icon, {
    Color? color,
  }) {
    final iconColor = color ?? AppColors.textPrimary;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 20),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showApplyDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Submit Proposal',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Write a short cover letter or upload your team resume.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
              SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  maxLines: 4,
                  style: TextStyle(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Why are you a good fit for this project?',
                    hintStyle: TextStyle(color: AppColors.textSecondary),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              SizedBox(height: 16),

              OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.attach_file, color: AppColors.accent),
                label: Text(
                  'Attach Resume / Portfolio',
                  style: TextStyle(color: AppColors.accent),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.accent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    MockStore.instance.addApplication({
                      'id': DateTime.now().microsecondsSinceEpoch.toString(),
                      'projectTitle': projectData['title'],
                      'studentId':
                          SessionService.instance.userId ?? 'student-1',
                      'status': 'Pending',
                      'coverNote':
                          'Interested in contributing to this project.',
                    });
                    MockStore.instance.addReminder({
                      'title': 'Follow up on application',
                      'detail': projectData['title'],
                      'date': 'In 3 days',
                      'done': false,
                      'kind': 'Form',
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Application Submitted Successfully!'),
                        backgroundColor: AppColors.accent,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Submit Application',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}


