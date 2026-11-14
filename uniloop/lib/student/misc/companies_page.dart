import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class CompaniesPage extends StatelessWidget {
  CompaniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final companies = [
      'Google',
      'Microsoft',
      'Amazon',
      'Goldman Sachs',
      'TCS',
      'Infosys',
      'Zomato',
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        title: Text(
          'Companies',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: companies.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.08)),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.background,
                child: Text(
                  companies[index][0],
                  style: TextStyle(color: AppColors.textPrimary),
                ),
              ),
              title: Text(
                companies[index],
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: AppColors.textSecondary,
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}


