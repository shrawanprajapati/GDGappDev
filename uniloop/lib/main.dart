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
    return ValueListenableBuilder<AppThemeSettings>(
      valueListenable: AppTheme.settings,
      builder: (context, settings, _) {
        AppTheme.syncCurrentColors();
        return MaterialApp(
          title: 'Uniloop',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: settings.mode,
          initialRoute: AppRoutes.onboarding,
          routes: {
            AppRoutes.onboarding: (_) => OnboardingPage(),
            AppRoutes.login: (_) => LoginPage(),
            AppRoutes.universityMember: (_) => UniversityMemberPage(),
            AppRoutes.universityLogin: (_) => UniversityLoginPage(),
            AppRoutes.industryLogin: (_) => IndustryLoginPage(),
            AppRoutes.studentDashboard: (_) => StudentDashboard(),
            AppRoutes.industryDashboard: (_) => IndustryDashboard(),
            AppRoutes.adminDashboard: (_) => AdminDashboard(),
            AppRoutes.alumniDashboard: (_) => AlumniDashboard(),
          },
        );
      },
    );
  }
}
