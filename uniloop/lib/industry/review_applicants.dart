import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/data/mock_store.dart';

Future<void> showApplicantReviewSheet(
  BuildContext context,
  List<Map<String, String>> applicants,
  String projectTitle,
) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.surface,
    isScrollControlled: true,
    builder: (_) => _ApplicantReviewSheet(
      projectTitle: projectTitle,
      applicants: applicants,
    ),
  );
}

class _ApplicantReviewSheet extends StatefulWidget {
  final String projectTitle;
  final List<Map<String, String>> applicants;

  _ApplicantReviewSheet({required this.projectTitle, required this.applicants});

  @override
  State<_ApplicantReviewSheet> createState() => _ApplicantReviewSheetState();
}

class _ApplicantReviewSheetState extends State<_ApplicantReviewSheet> {
  final decisions = <String, String>{};
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: EdgeInsets.fromLTRB(20, 18, 20, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Applicants · ${widget.projectTitle}',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          ...widget.applicants.map(_applicant),
        ],
      ),
    ),
  );
  Widget _applicant(Map<String, String> applicant) {
    final name = applicant['name']!;
    final decision = decisions[name];
    return Card(
      color: AppColors.background,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              applicant['course']!,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
            Text(
              applicant['skills']!,
              style: TextStyle(color: AppColors.accent, fontSize: 12),
            ),
            SizedBox(height: 8),
            Text(
              '85% skill match',
              style: TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (decision == null)
              Row(
                children: [
                  _decision('Accept', AppColors.accent, name),
                  _decision('Shortlist', AppColors.primary, name),
                  _decision('Reject', AppColors.textSecondary, name),
                ],
              )
            else
              Text(
                decision,
                style: TextStyle(
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _decision(String label, Color color, String name) => Expanded(
    child: Padding(
      padding: EdgeInsets.only(right: 6),
      child: OutlinedButton(
        onPressed: () {
          setState(() => decisions[name] = label);
          final user = MockStore.instance.users.firstWhere(
            (item) => item['name'] == name,
            orElse: () => {'id': 'student-1'},
          );
          MockStore.instance.addNotification(
            userId: user['id'],
            type: 'Projects',
            text: 'Your application was $label.',
            route: '/student-dashboard',
          );
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color),
        ),
        child: Text(label, style: TextStyle(fontSize: 11)),
      ),
    ),
  );
}
