import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../club_theme_config.dart';

/// Generic public-facing club page.
///
/// This is the page students see when they tap on a club that does NOT
/// have a custom theme.  It uses the app's standard dark theme and
/// displays all the data from [ClubPageData].
///
/// When a club creates an account, the app automatically shows this page.
class DefaultClubPage extends StatelessWidget {
  const DefaultClubPage({super.key, required this.data});

  final ClubPageData data;

  @override
  Widget build(BuildContext context) {
    final Color accent = data.accentColor ?? AppColors.primary;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ────────── HEADER ──────────
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    data.logoIcon ?? Icons.group,
                    color: accent,
                    size: 48,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.clubName,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.instituteName,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ────────── ACTION BUTTONS ──────────
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Join club flow
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Join Club',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: View projects
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: accent),
                      foregroundColor: accent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('View Projects'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ────────── ABOUT ──────────
            const Text(
              'About',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              data.description,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            // ────────── EVENTS ──────────
            if (data.events.isNotEmpty) ...[
              const Text(
                'Events',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              ...data.events.map((e) => _eventCard(e, accent)),
              const SizedBox(height: 20),
            ],

            // ────────── TEAM ──────────
            if (data.team.isNotEmpty) ...[
              const Text(
                'Team',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              ...data.team.map((m) => _memberTile(m, accent)),
              const SizedBox(height: 20),
            ],

            // ────────── SOCIAL LINKS ──────────
            if (data.socialLinks.isNotEmpty) ...[
              const Text(
                'Connect',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: data.socialLinks.entries.map((entry) {
                  return Chip(
                    avatar: Icon(Icons.link, color: accent, size: 16),
                    label: Text(
                      entry.key[0].toUpperCase() + entry.key.substring(1),
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 12,
                      ),
                    ),
                    backgroundColor: AppColors.surface,
                    side: BorderSide(
                      color: accent.withValues(alpha: 0.3),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _eventCard(ClubEvent event, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: event.isUpcoming
              ? accent.withValues(alpha: 0.3)
              : Colors.transparent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  event.title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: event.isUpcoming
                      ? accent.withValues(alpha: 0.2)
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  event.isUpcoming ? 'Upcoming' : 'Past',
                  style: TextStyle(
                    color: event.isUpcoming ? accent : AppColors.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${event.date} • ${event.time} • ${event.venue}',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _memberTile(ClubTeamMember member, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: accent.withValues(alpha: 0.15),
          child: Text(
            member.name.isNotEmpty ? member.name[0] : '?',
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          member.name,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${member.role}${member.department.isNotEmpty ? ' • ${member.department}' : ''}',
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
