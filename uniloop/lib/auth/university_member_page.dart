import 'package:flutter/material.dart';

class UniversityMemberPage extends StatelessWidget {
  const UniversityMemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
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
                  color: Color(0xFF1E1E1E),
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
        // TODO: Yahan hum next step (Login Form) pe jayenge
        print('$title selected');
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            const Icon(
              Icons.description_outlined,
              size: 22,
              color: Color(0xFF4A4A4A),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2C2C2C),
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