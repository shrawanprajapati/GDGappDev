import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'core/app_routes.dart';
import 'onboarding/onboarding_page.dart';
import 'auth/login_page.dart';
import 'auth/university_login_page.dart';
import 'auth/industry_login_page.dart';
import 'auth/university_member_page.dart';
import 'student/dashboard/student_dashboard.dart'; // Updated Import
import 'industry/dashboard/industry_dashboard.dart';
import 'admin/dashboard/admin_dashboard.dart';
import 'alumni_portal/dashboard/alumni_dashboard.dart';

void main() => runApp(const UniloopApp());

class UniloopApp extends StatelessWidget {
  const UniloopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uniloop',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      initialRoute: AppRoutes.onboarding,
      routes: {
        AppRoutes.onboarding: (_) => const OnboardingPage(),
        AppRoutes.login: (_) => const LoginPage(),
        AppRoutes.universityMember: (_) => const UniversityMemberPage(),
        AppRoutes.universityLogin: (_) => const UniversityLoginPage(),
        AppRoutes.industryLogin: (_) => const IndustryLoginPage(),
        AppRoutes.studentDashboard: (_) =>
            const StudentDashboard(), // Updated Route
        AppRoutes.industryDashboard: (_) => const IndustryDashboard(),
        AppRoutes.adminDashboard: (_) => const AdminDashboard(),
        AppRoutes.alumniDashboard: (_) => const AlumniDashboard(),
      },
    );
  }
}
