import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'create_event_page.dart';

class ClubEventsTab extends StatelessWidget {
  const ClubEventsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Your Events',
              style: TextStyle(
                color: ClubColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateEventPage(),
                ),
              ),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Create'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ClubColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        _buildEventCard(
          context,
          title: 'Tech Fest 2024',
          subtitle: 'Oct 24 • Main Audi',
          stats: '120 Registered',
          isActive: true,
        ),
        _buildEventCard(
          context,
          title: 'GDG Induction Task',
          subtitle: 'Nov 01 • Online',
          stats: '85 Applied',
          isActive: true,
        ),
        _buildEventCard(
          context,
          title: 'Web Dev Workshop',
          subtitle: 'Sep 15 • CS Lab',
          stats: 'Completed',
          isActive: false,
        ),
      ],
    );
  }

  Widget _buildEventCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String stats,
    required bool isActive,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ClubColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive
              ? ClubColors.accent.withValues(alpha: 0.3)
              : Colors.transparent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: ClubColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isActive)
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: ClubColors.textSecondary,
                  ),
                  color: ClubColors.surface,
                  onSelected: (value) {
                    if (value == 'delete') {
                      // Delete logic
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text(
                        'Edit Event',
                        style: TextStyle(color: ClubColors.textPrimary),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text(
                        'Delete Event',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: ClubColors.textSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? ClubColors.accent.withValues(alpha: 0.2)
                      : ClubColors.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  stats,
                  style: TextStyle(
                    color: isActive
                        ? ClubColors.accent
                        : ClubColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isActive)
                TextButton(
                  onPressed: () => _showApplicantsBottomSheet(context, title),
                  child: const Text(
                    'View Applicants',
                    style: TextStyle(
                      color: ClubColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // Applicants List Bottom Sheet
  void _showApplicantsBottomSheet(BuildContext context, String eventName) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ClubColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                // Handle
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Applicants: $eventName',
                        style: const TextStyle(
                          color: ClubColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '85 Total',
                        style: TextStyle(
                          color: ClubColors.accent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(color: Colors.white12),

                // List
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 4, // Dummy 4 applicants
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: ClubColors.background,
                          child: Text(
                            'S${index + 1}',
                            style: const TextStyle(
                              color: ClubColors.textPrimary,
                            ),
                          ),
                        ),
                        title: Text(
                          'Student ${index + 1}',
                          style: const TextStyle(
                            color: ClubColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: const Text(
                          'CSE • 2nd Year',
                          style: TextStyle(
                            color: ClubColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.check_circle,
                                color: ClubColors.accent,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
