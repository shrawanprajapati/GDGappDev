import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../events/create_event_page.dart';

class ClubDashboard extends StatefulWidget {
  const ClubDashboard({super.key});

  @override
  State<ClubDashboard> createState() => _ClubDashboardState();
}

class _ClubDashboardState extends State<ClubDashboard> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const _ClubHomeTab(),
    const _ClubEventsTab(),
    const _ClubManagePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Club Portal', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.textPrimary),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          )
        ],
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'My Club'),
        ],
      ),
    );
  }
}

// --- TAB 1: HOME ---
class _ClubHomeTab extends StatelessWidget {
  const _ClubHomeTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Welcome back, GDG Club', style: TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          
          // Stats
          Row(
            children: [
              _buildStatCard('Active Events', '3', AppColors.primary),
              const SizedBox(width: 12),
              _buildStatCard('Applications', '145', AppColors.accent),
            ],
          ),
          const SizedBox(height: 30),

          const Text('Recent Activity', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          
          _buildActivityCard('Rahul applied for GDG Induction', '2 hours ago'),
          _buildActivityCard('Tech Fest 2024 registration started', '1 day ago'),
          
          const SizedBox(height: 30),

          const Text('Quick Actions', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildActionButton(context, 'Post New Event / Induction', Icons.add_box_outlined, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateEventPage()));
          }),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(color: color, fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(String text, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          const Icon(Icons.notifications_active, color: AppColors.accent, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(color: AppColors.textPrimary, fontSize: 14))),
          Text(time, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Icon(icon, color: AppColors.accent),
            const SizedBox(width: 16),
            Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: AppColors.textSecondary, size: 16),
          ],
        ),
      ),
    );
  }
}

// --- TAB 2: MANAGE EVENTS ---
class _ClubEventsTab extends StatelessWidget {
  const _ClubEventsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Your Events', style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateEventPage())),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Create'),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
            )
          ],
        ),
        const SizedBox(height: 20),
        _buildEventCard('Tech Fest 2024', 'Oct 24 • Main Audi', '120 Registered', true),
        _buildEventCard('GDG Induction Task', 'Nov 01 • Online', '85 Applied', true),
        _buildEventCard('Web Dev Workshop', 'Sep 15 • CS Lab', 'Completed', false),
      ],
    );
  }

  Widget _buildEventCard(String title, String subtitle, String stats, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface, 
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isActive ? AppColors.accent.withValues(alpha: 0.3) : Colors.transparent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
              if (isActive)
                const Icon(Icons.more_vert, color: AppColors.textSecondary)
            ],
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.accent.withValues(alpha: 0.2) : AppColors.background, 
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Text(stats, style: TextStyle(color: isActive ? AppColors.accent : AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// --- TAB 3: MANAGE CLUB PROFILE ---
class _ClubManagePage extends StatelessWidget {
  const _ClubManagePage();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('My Club Profile', style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                const CircleAvatar(radius: 40, backgroundColor: AppColors.primary, child: Icon(Icons.computer, size: 40, color: Colors.white)),
                const SizedBox(height: 16),
                const Text('GDG - Technical Club', style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('Technical Domain • 450+ Members', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
                        child: const Text('Edit Details'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.accent), foregroundColor: AppColors.accent),
                        child: const Text('View Public Page'),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 30),

          const Text('Club Members', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildMemberCard('Shrawan Prajapati', 'Core Team • CSE 2026'),
          _buildMemberCard('Rahul Sharma', 'Web Dev Lead • CSE 2025'),
        ],
      ),
    );
  }

  Widget _buildMemberCard(String name, String role) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(backgroundColor: AppColors.background, child: Text(name[0], style: const TextStyle(color: AppColors.textPrimary))),
        title: Text(name, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        subtitle: Text(role, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      ),
    );
  }
}