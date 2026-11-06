import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'core/app_routes.dart';
import 'onboarding/onboarding_page.dart';

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
      },
    );
  }
}