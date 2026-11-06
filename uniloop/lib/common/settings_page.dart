import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = true; // Default dark theme
  bool _notifications = true;

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
            value: _notifications,
            activeColor: AppColors.accent,
            onChanged: (val) {
              setState(() {
                _notifications = val;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Dark Mode', style: TextStyle(color: AppColors.textPrimary)),
            subtitle: const Text('Toggle light/dark theme', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            value: _isDarkMode,
            activeColor: AppColors.accent,
            onChanged: (val) {
              setState(() {
                _isDarkMode = val;
              });
              // TODO: Jab hum main.dart me ThemeProvider lagayenge, tab ye global theme change karega.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Theme updated! (Global implementation pending)')),
              );
            },
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