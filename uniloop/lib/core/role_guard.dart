import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'session_service.dart';

class RoleGuard extends StatelessWidget {
  RoleGuard({super.key, required this.allowedRole, required this.child});
  final String allowedRole;
  final Widget child;
  @override
  Widget build(BuildContext context) =>
      SessionService.instance.role == null ||
          SessionService.instance.role == allowedRole
      ? child
      : Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            title: Text(
              'Access restricted',
              style: TextStyle(color: AppColors.textPrimary),
            ),
          ),
          body: Center(
            child: Text(
              'This screen is not available for your role.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
        );
}
