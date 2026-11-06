import 'package:flutter/material.dart';
import '../core/app_colors.dart'; // Path update kiya

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text('Settings', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Push Notifications', style: TextStyle(color: AppColors.textPrimary)),
            subtitle: const Text('Get alerts for events and tasks', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            value: true,
            activeColor: AppColors.accent,
            onChanged: (val) {},
          ),
          SwitchListTile(
            title: const Text('Dark Mode', style: TextStyle(color: AppColors.textPrimary)),
            subtitle: const Text('Use dark theme (Default)', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            value: true,
            activeColor: AppColors.accent,
            onChanged: (val) {},
          ),
          const Divider(color: Colors.white12),
          ListTile(
            title: const Text('Change Password', style: TextStyle(color: AppColors.textPrimary)),
            trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Delete Account', style: TextStyle(color: Colors.redAccent)),
            trailing: const Icon(Icons.chevron_right, color: Colors.redAccent),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}