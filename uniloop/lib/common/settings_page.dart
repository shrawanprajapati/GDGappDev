import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import 'logout_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppThemeSettings>(
      valueListenable: AppTheme.settings,
      builder: (context, settings, _) {
        final scheme = Theme.of(context).colorScheme;
        final isDark = settings.mode == ThemeMode.dark;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: ListView(
            children: [
              SwitchListTile(
                title: const Text('Push Notifications'),
                subtitle: const Text('Get alerts for events and tasks'),
                value: _notifications,
                activeThumbColor: scheme.secondary,
                onChanged: (value) => setState(() => _notifications = value),
              ),
              SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Toggle light/dark appearance'),
                value: isDark,
                activeThumbColor: scheme.secondary,
                onChanged: (value) {
                  AppTheme.setDarkMode(value);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        value ? 'Dark theme enabled' : 'Light theme enabled',
                      ),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Theme style'),
                subtitle: Text(_presetName(settings.preset)),
                trailing: const Icon(Icons.palette_outlined),
                onTap: _chooseTheme,
              ),
              const Divider(),
              ListTile(
                title: const Text('Change Password'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showMessage(
                  'Password flow is ready for backend integration.',
                ),
              ),
              ListTile(
                title: const Text('Logout'),
                leading: Icon(Icons.logout, color: scheme.secondary),
                onTap: () => LogoutDialog.show(context),
              ),
              ListTile(
                title: Text(
                  'Delete Account',
                  style: TextStyle(color: scheme.error),
                ),
                trailing: Icon(Icons.chevron_right, color: scheme.error),
                onTap: () => _showMessage(
                  'Account deletion is disabled in UI-only mode.',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _chooseTheme() async {
    final selected = await showModalBottomSheet<ThemePreset>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Choose your UniLoop style',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            for (final preset in ThemePreset.values)
              ListTile(
                leading: CircleAvatar(backgroundColor: _presetColor(preset)),
                title: Text(_presetName(preset)),
                subtitle: Text(_presetDescription(preset)),
                trailing: AppTheme.settings.value.preset == preset
                    ? const Icon(Icons.check_circle)
                    : null,
                onTap: () => Navigator.pop(sheetContext, preset),
              ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );

    if (!mounted || selected == null) return;
    AppTheme.setPreset(selected);
    _showMessage('${_presetName(selected)} theme selected.');
  }

  String _presetName(ThemePreset preset) {
    switch (preset) {
      case ThemePreset.warm:
        return 'Warm campus';
      case ThemePreset.lavender:
        return 'Lavender focus';
      case ThemePreset.ocean:
        return 'Ocean calm';
    }
  }

  String _presetDescription(ThemePreset preset) {
    switch (preset) {
      case ThemePreset.warm:
        return 'Terracotta, gold, and cozy espresso';
      case ThemePreset.lavender:
        return 'Creative violet with soft rose accents';
      case ThemePreset.ocean:
        return 'Calm blue with refreshing teal accents';
    }
  }

  Color _presetColor(ThemePreset preset) {
    switch (preset) {
      case ThemePreset.warm:
        return const Color(0xFFC87552);
      case ThemePreset.lavender:
        return const Color(0xFF8B6FE8);
      case ThemePreset.ocean:
        return const Color(0xFF3E9BD3);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
