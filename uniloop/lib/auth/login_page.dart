import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              
              // Heading
              const Text(
                'Get Started with',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: -1.0,
                ),
              ),
              
              const SizedBox(height: 60),
              
              // University member option
              _buildRoleOption(
                context: context,
                title: 'University member',
                icon: Icons.school_outlined,
                onTap: () {
                  // Aage naya login page khulega
                  Navigator.pushNamed(context, AppRoutes.universityLogin);
                },
              ),
              
              const SizedBox(height: 24),
              
              // Industry/company option
              _buildRoleOption(
                context: context,
                title: 'Industry/company',
                icon: Icons.business_outlined,
                onTap: () {
                  // Industry Login will be built later
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleOption({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: AppColors.accent),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}