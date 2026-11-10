import 'package:flutter/material.dart';
import '../club_theme_config.dart';
import 'gdg_colors.dart';

/// Custom-themed public page for the Google Developer Group club.
///
/// Uses a **white/light background** with Google brand colours and
/// pixel-art-inspired decorations to match the GDG visual identity.
class GdgClubPage extends StatelessWidget {
  const GdgClubPage({super.key, required this.data});

  final ClubPageData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GdgColors.background,
      body: CustomScrollView(
        slivers: [
          // ────────────── 1. HERO APP BAR ──────────────
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: GdgColors.surface,
            iconTheme: const IconThemeData(color: GdgColors.textPrimary),
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHero(),
            ),
            title: const Text(
              'GDG',
              style: TextStyle(
                color: GdgColors.textPrimary,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
          ),

          // ────────────── BODY ──────────────
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. Featured event banner
                if (data.events.isNotEmpty) _buildFeaturedEvent(data.events.first),

                // 3. About section
                _buildAbout(),

                // 4. Upcoming events
                if (data.events.where((e) => e.isUpcoming).length > 1)
                  _buildUpcomingEvents(),

                // 5. Our team
                if (data.team.isNotEmpty) _buildTeam(),

                // 6. Past highlights
                if (data.pastHighlights.isNotEmpty) _buildPastHighlights(),

                // 7. Social links
                if (data.socialLinks.isNotEmpty) _buildSocialLinks(),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // 1. HERO
  // ═══════════════════════════════════════════════════════════════
  Widget _buildHero() {
    return Container(
      decoration: BoxDecoration(
        color: GdgColors.surface,
        border: Border(
          bottom: BorderSide(color: GdgColors.cardBorder, width: 1),
        ),
      ),
      child: Stack(
        children: [
          // Decorative Google-colour bar at top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              children: GdgColors.googleColors
                  .map((c) => Expanded(child: Container(height: 4, color: c)))
                  .toList(),
            ),
          ),

          // Pixel sparkles decoration
          ..._buildPixelSparkles(),

          // Center content
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // GDG logo (4 coloured dots)
                  _buildGdgLogo(),
                  const SizedBox(height: 12),
                  const Text(
                    'Google Developer Group',
                    style: TextStyle(
                      color: GdgColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.instituteName,
                    style: const TextStyle(
                      color: GdgColors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGdgLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: GdgColors.googleColors
          .map(
            (c) => Container(
              width: 16,
              height: 16,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: c,
                borderRadius: BorderRadius.circular(3), // slightly pixelated
              ),
            ),
          )
          .toList(),
    );
  }

  List<Widget> _buildPixelSparkles() {
    // Small decorative crosses at random spots
    return [
      _pixelCross(top: 80, left: 30, color: GdgColors.blue),
      _pixelCross(top: 120, right: 40, color: GdgColors.yellow),
      _pixelCross(top: 160, left: 60, color: GdgColors.green),
      _pixelCross(top: 100, right: 80, color: GdgColors.red),
    ];
  }

  Widget _pixelCross({
    double? top,
    double? left,
    double? right,
    required Color color,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: SizedBox(
        width: 12,
        height: 12,
        child: CustomPaint(painter: _PixelCrossPainter(color: color)),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // 2. FEATURED EVENT
  // ═══════════════════════════════════════════════════════════════
  Widget _buildFeaturedEvent(ClubEvent event) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: GdgColors.surface,
          borderRadius: BorderRadius.circular(4), // pixel-sharp
          border: Border.all(color: GdgColors.blue, width: 2),
          boxShadow: [
            BoxShadow(
              color: GdgColors.blue.withValues(alpha: 0.10),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top colour bar (pixel-game style)
            Row(
              children: GdgColors.googleColors
                  .map((c) => Expanded(child: Container(height: 6, color: c)))
                  .toList(),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: GdgColors.blue.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      event.category.toUpperCase(),
                      style: const TextStyle(
                        color: GdgColors.blue,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Title
                  Text(
                    event.title,
                    style: const TextStyle(
                      color: GdgColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  if (event.description.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      event.description,
                      style: const TextStyle(
                        color: GdgColors.textSecondary,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),

                  // Event info row (Date | Time | Venue)
                  Row(
                    children: [
                      _eventInfoChip(Icons.calendar_today, event.date, GdgColors.blue),
                      const SizedBox(width: 8),
                      _eventInfoChip(Icons.access_time, event.time, GdgColors.green),
                      const SizedBox(width: 8),
                      _eventInfoChip(Icons.place, event.venue, GdgColors.red),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Register button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Registration flow
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GdgColors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _eventInfoChip(IconData icon, String text, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color.withValues(alpha: 0.20)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(height: 4),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // 3. ABOUT
  // ═══════════════════════════════════════════════════════════════
  Widget _buildAbout() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('About Us', GdgColors.green),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: GdgColors.surface,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: GdgColors.cardBorder),
            ),
            child: Text(
              data.description,
              style: const TextStyle(
                color: GdgColors.textSecondary,
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Quick stats row
          Row(
            children: [
              _statCard('${data.team.length}+', 'Members', GdgColors.blue),
              const SizedBox(width: 10),
              _statCard(
                '${data.events.length}',
                'Events',
                GdgColors.red,
              ),
              const SizedBox(width: 10),
              _statCard(
                '${data.pastHighlights.length}',
                'Highlights',
                GdgColors.yellow,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: GdgColors.surface,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                color: GdgColors.textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // 4. UPCOMING EVENTS
  // ═══════════════════════════════════════════════════════════════
  Widget _buildUpcomingEvents() {
    final upcoming = data.events.where((e) => e.isUpcoming).skip(1).toList();
    if (upcoming.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _sectionTitle('Upcoming Events', GdgColors.blue),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: upcoming.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, i) => _upcomingEventCard(upcoming[i], i),
            ),
          ),
        ],
      ),
    );
  }

  Widget _upcomingEventCard(ClubEvent event, int index) {
    final color = GdgColors.googleColors[index % 4];
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GdgColors.surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  event.category,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                event.title,
                style: const TextStyle(
                  color: GdgColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 13, color: color),
              const SizedBox(width: 6),
              Text(
                '${event.date} • ${event.time}',
                style: const TextStyle(
                  color: GdgColors.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // 5. TEAM
  // ═══════════════════════════════════════════════════════════════
  Widget _buildTeam() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Our Team', GdgColors.red),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: data.team.length,
            itemBuilder: (context, i) => _teamMemberCard(data.team[i], i),
          ),
        ],
      ),
    );
  }

  Widget _teamMemberCard(ClubTeamMember member, int index) {
    final color = GdgColors.googleColors[index % 4];
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: GdgColors.surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: GdgColors.cardBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withValues(alpha: 0.15),
            child: Text(
              member.name.isNotEmpty ? member.name[0] : '?',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            member.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: GdgColors.textPrimary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            member.role,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // 6. PAST HIGHLIGHTS
  // ═══════════════════════════════════════════════════════════════
  Widget _buildPastHighlights() {
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _sectionTitle('Past Highlights', GdgColors.yellow),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: data.pastHighlights.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, i) {
                final color = GdgColors.googleColors[i % 4];
                return Container(
                  width: 200,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: GdgColors.surface,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: color.withValues(alpha: 0.25)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.emoji_events, color: color, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          data.pastHighlights[i],
                          style: const TextStyle(
                            color: GdgColors.textPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // 7. SOCIAL LINKS
  // ═══════════════════════════════════════════════════════════════
  Widget _buildSocialLinks() {
    final iconMap = <String, IconData>{
      'github': Icons.code,
      'linkedin': Icons.work_outline,
      'instagram': Icons.camera_alt_outlined,
      'twitter': Icons.alternate_email,
      'website': Icons.language,
      'youtube': Icons.play_circle_outline,
      'discord': Icons.chat_bubble_outline,
    };

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Connect With Us', GdgColors.green),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: data.socialLinks.entries.map((entry) {
              final color =
                  GdgColors.googleColors[entry.key.length % 4];
              return InkWell(
                onTap: () {
                  // TODO: Launch URL (url_launcher package)
                },
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: GdgColors.surface,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: color.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        iconMap[entry.key.toLowerCase()] ?? Icons.link,
                        size: 18,
                        color: color,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        entry.key[0].toUpperCase() + entry.key.substring(1),
                        style: TextStyle(
                          color: color,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // HELPERS
  // ═══════════════════════════════════════════════════════════════
  Widget _sectionTitle(String title, Color accentColor) {
    return Row(
      children: [
        Container(width: 4, height: 20, color: accentColor),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: GdgColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════
// Pixel-art sparkle custom painter (small cross / plus shape)
// ═════════════════════════════════════════════════════════════════
class _PixelCrossPainter extends CustomPainter {
  const _PixelCrossPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withValues(alpha: 0.35);
    final unit = size.width / 3;

    // Vertical bar
    canvas.drawRect(Rect.fromLTWH(unit, 0, unit, size.height), paint);
    // Horizontal bar
    canvas.drawRect(Rect.fromLTWH(0, unit, size.width, unit), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
