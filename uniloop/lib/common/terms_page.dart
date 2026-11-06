import 'package:flutter/material.dart';
import '../core/app_colors.dart'; // Path update kiya

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Text(
          '1. Acceptance of Terms\nBy using UniLoop, you agree to these terms.\n\n'
          '2. User Responsibilities\nYou are responsible for maintaining the confidentiality of your account and for all activities under it.\n\n'
          '3. Content\nAll content posted on the platform must be lawful and respectful.\n\n'
          '4. Privacy\nWe value your privacy. Your data is used only to improve your experience.\n\n'
          '5. Termination\nWe reserve the right to suspend accounts that violate these terms.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 15,
            height: 1.6,
          ),
        ),
      ),
    );
  }
}
