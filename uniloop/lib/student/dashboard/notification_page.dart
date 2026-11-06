import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Notifications
    final notifications = [
      {
        'title': 'Task Assigned',
        'desc': 'You have been assigned "Integrate Google Maps API" in Campus Navigation App.',
        'time': '2 mins ago',
        'icon': Icons.assignment,
        'color': Colors.blueAccent,
        'isUnread': true,
      },
      {
        'title': 'Application Accepted!',
        'desc': 'Congratulations! Your proposal for GDG Recruitment Task was accepted.',
        'time': '1 hour ago',
        'icon': Icons.check_circle,
        'color': AppColors.accent,
        'isUnread': true,
      },
      {
        'title': 'New Event: Tech Fest 2024',
        'desc': 'Registrations are now open for the annual Tech Fest. Register before Oct 20.',
        'time': '5 hours ago',
        'icon': Icons.event,
        'color': Colors.orangeAccent,
        'isUnread': false,
      },
      {
        'title': 'Team Invite',
        'desc': 'Rahul invited you to join the team "Design Innovators" for Vishwakarma Award.',
        'time': 'Yesterday',
        'icon': Icons.people,
        'color': Colors.purpleAccent,
        'isUnread': false,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text('Notifications', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Mark all as read
            },
            child: const Text('Mark all read', style: TextStyle(color: AppColors.accent, fontSize: 13)),
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return _buildNotificationCard(context, notif);
        },
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, Map<String, dynamic> notif) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: notif['isUnread'] ? AppColors.surface : AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: notif['isUnread'] ? AppColors.primary.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: notif['color'].withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(notif['icon'], color: notif['color'], size: 20),
          ),
          const SizedBox(width: 16),
          
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      notif['title'], 
                      style: const TextStyle(color: AppColors.textPrimary, fontSize: 15, fontWeight: FontWeight.w700)
                    ),
                    Text(
                      notif['time'], 
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  notif['desc'], 
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}