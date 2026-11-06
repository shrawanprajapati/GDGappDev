import 'package:flutter/material.dart';
import '../app_colors.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});
  final String status;
  @override
  Widget build(BuildContext context) {
    final color =
        {
          'Accepted': AppColors.accent,
          'Approved': AppColors.accent,
          'Shortlisted': AppColors.primary,
          'Rejected': AppColors.textSecondary,
          'Declined': AppColors.textSecondary,
          'Pending': AppColors.primary,
        }[status] ??
        AppColors.textSecondary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
