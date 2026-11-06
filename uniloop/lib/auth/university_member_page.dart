import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class UniversityMemberPage extends StatelessWidget {
  const UniversityMemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'University member',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: -1.0,
                ),
              ),

              const SizedBox(height: 60),

              // List of sub-roles
              _buildSubRole(context, 'Student'),
              _buildSubRole(context, 'Professors'),
              _buildSubRole(context, 'Clubs'),
              _buildSubRole(context, 'Administration'),
              _buildSubRole(context, 'Workers'),
              _buildSubRole(context, 'Alumni'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubRole(BuildContext context, String title) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title login is available from the role selector.'),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            const Icon(
              Icons.description_outlined,
              size: 22,
              color: AppColors.accent,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
                decoration: TextDecoration.underline,
                decorationThickness: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
