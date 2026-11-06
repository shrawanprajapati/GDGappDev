import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/data/mock_store.dart';
import '../post_project/post_project_page.dart';
import '../hiring_pipeline.dart';
import '../review_applicants.dart';

class IndustryDashboard extends StatefulWidget {
  const IndustryDashboard({super.key});

  @override
  State<IndustryDashboard> createState() => _IndustryDashboardState();
}

class _IndustryDashboardState extends State<IndustryDashboard> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _projects = [
    {
      'title': 'Campus Mobility Platform',
      'description':
          'Build a live shuttle tracking experience for university students.',
      'skills': ['Flutter', 'Maps', 'Firebase'],
      'budget': '₹80,000',
      'timeline': '8 weeks',
      'applicants': 18,
      'status': 'Active',
    },
    {
      'title': 'AI Resume Coach',
      'description':
          'Create an AI-assisted resume feedback workflow for graduating students.',
      'skills': ['Python', 'NLP', 'UX Research'],
      'budget': '₹60,000',
      'timeline': '6 weeks',
      'applicants': 11,
      'status': 'Reviewing',
    },
  ];

  final List<Map<String, String>> _activities = [
    {
      'title': 'New application received',
      'subtitle': 'Campus Mobility Platform · 12 min ago',
    },
    {
      'title': 'Project moved to reviewing',
      'subtitle': 'AI Resume Coach · Yesterday',
    },
    {
      'title': 'Shortlisted student replied',
      'subtitle': 'Priya Sharma · 2 days ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [_buildHome(), _buildProjects(), _buildProfile()];
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          _currentIndex == 0
              ? 'Industry Portal'
              : _currentIndex == 1
              ? 'Your Projects'
              : 'Company Profile',
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      body: SafeArea(child: pages[_currentIndex]),
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton.extended(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textPrimary,
              onPressed: _openPostProject,
              icon: const Icon(Icons.add),
              label: const Text('Post Project'),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            activeIcon: Icon(Icons.work),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_outlined),
            activeIcon: Icon(Icons.business),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildHome() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Text(
        'Good morning, Acme Labs',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 6),
      const Text(
        'Track your university partnerships at a glance.',
        style: TextStyle(color: AppColors.textSecondary),
      ),
      const SizedBox(height: 24),
      Row(
        children: [
          _statCard(
            'Active Projects',
            '${_projects.where((p) => p['status'] == 'Active').length}',
            Icons.rocket_launch_outlined,
          ),
          const SizedBox(width: 12),
          _statCard('Total Applicants', '29', Icons.groups_outlined),
        ],
      ),
      const SizedBox(height: 28),
      _sectionTitle('Recent Activity'),
      const SizedBox(height: 12),
      ..._activities.map((activity) => _activityTile(activity)),
      const SizedBox(height: 20),
      _sectionTitle('Quick Actions'),
      const SizedBox(height: 12),
      _actionTile(
        Icons.add_circle_outline,
        'Post a new project',
        'Find talented university teams',
        _openPostProject,
      ),
      _actionTile(
        Icons.people_outline,
        'Review applicants',
        'Continue where you left off',
        () => setState(() => _currentIndex = 1),
      ),
      _actionTile(
        Icons.account_tree_outlined,
        'Hiring pipeline',
        'Move candidates through your hiring stages',
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HiringPipelinePage()),
        ),
      ),
    ],
  );

  Widget _buildProjects() => ListView(
    padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
    children: [
      const Text(
        'Manage opportunities and review student applications.',
        style: TextStyle(color: AppColors.textSecondary),
      ),
      const SizedBox(height: 18),
      ..._projects.asMap().entries.map(
        (entry) => _projectCard(entry.value, entry.key),
      ),
    ],
  );

  Widget _buildProfile() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      Center(
        child: CircleAvatar(
          radius: 38,
          backgroundColor: AppColors.primary,
          child: const Icon(
            Icons.business,
            color: AppColors.textPrimary,
            size: 34,
          ),
        ),
      ),
      const SizedBox(height: 14),
      const Center(
        child: Text(
          'Acme Labs',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const Center(
        child: Text(
          'Technology & Innovation',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      ),
      const SizedBox(height: 28),
      _profileRow(
        Icons.email_outlined,
        'Email',
        'partnerships@acmelabs.example',
      ),
      _profileRow(Icons.phone_outlined, 'Phone', '+91 98765 43210'),
      _profileRow(Icons.location_on_outlined, 'Location', 'Bengaluru, India'),
      _profileRow(Icons.language_outlined, 'Website', 'www.acmelabs.example'),
      const SizedBox(height: 20),
      OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.edit_outlined),
        label: const Text('Edit Company Details'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.accent,
          side: const BorderSide(color: AppColors.accent),
          padding: const EdgeInsets.all(15),
        ),
      ),
    ],
  );

  Widget _statCard(String label, String value, IconData icon) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.accent),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  );

  Widget _sectionTitle(String title) => Text(
    title,
    style: const TextStyle(
      color: AppColors.textPrimary,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );

  Widget _activityTile(Map<String, String> activity) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: const CircleAvatar(
      backgroundColor: AppColors.surface,
      child: Icon(Icons.bolt, color: AppColors.accent),
    ),
    title: Text(
      activity['title']!,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    ),
    subtitle: Text(
      activity['subtitle']!,
      style: const TextStyle(color: AppColors.textSecondary),
    ),
  );

  Widget _actionTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) => Card(
    color: AppColors.surface,
    margin: const EdgeInsets.only(bottom: 10),
    child: ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppColors.accent),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: AppColors.textSecondary),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
    ),
  );

  Widget _projectCard(Map<String, dynamic> project, int index) => Card(
    color: AppColors.surface,
    margin: const EdgeInsets.only(bottom: 14),
    child: InkWell(
      onTap: () => _showApplicants(project),
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    project['title'],
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _statusChip(project['status']),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              project['description'],
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 6,
              children: (project['skills'] as List<String>)
                  .map(
                    (skill) => Chip(
                      label: Text(
                        skill,
                        style: const TextStyle(
                          color: AppColors.accent,
                          fontSize: 11,
                        ),
                      ),
                      backgroundColor: AppColors.background,
                      side: BorderSide.none,
                      visualDensity: VisualDensity.compact,
                    ),
                  )
                  .toList(),
            ),
            const Divider(color: AppColors.background),
            Row(
              children: [
                const Icon(
                  Icons.payments_outlined,
                  size: 17,
                  color: AppColors.accent,
                ),
                const SizedBox(width: 5),
                Text(
                  project['budget'],
                  style: const TextStyle(color: AppColors.textPrimary),
                ),
                const SizedBox(width: 18),
                const Icon(
                  Icons.schedule_outlined,
                  size: 17,
                  color: AppColors.accent,
                ),
                const SizedBox(width: 5),
                Text(
                  project['timeline'],
                  style: const TextStyle(color: AppColors.textPrimary),
                ),
                const Spacer(),
                Text(
                  '${project['applicants']} applicants',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  Widget _statusChip(String status) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(
      color: AppColors.accent.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      status,
      style: const TextStyle(
        color: AppColors.accent,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  Widget _profileRow(IconData icon, String label, String value) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Icon(icon, color: AppColors.accent),
    title: Text(
      label,
      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
    ),
    subtitle: Text(
      value,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 15),
    ),
  );

  void _openPostProject() async {
    final project = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const PostProjectPage()),
    );
    if (project != null) {
      final projectWithId = {
        ...project,
        'id': DateTime.now().microsecondsSinceEpoch.toString(),
        'postedBy': 'Acme Labs',
        'domain': 'Industry',
        'status': 'Open',
      };
      MockStore.instance.addProject(projectWithId);
      setState(() => _projects.insert(0, projectWithId));
    }
  }

  void _showApplicants(Map<String, dynamic> project) {
    final applicants = [
      {
        'name': 'Aarav Mehta',
        'course': 'B.Tech Computer Science',
        'skills': 'Flutter · Firebase',
      },
      {
        'name': 'Priya Sharma',
        'course': 'B.Des Interaction Design',
        'skills': 'UX Research · Figma',
      },
      {
        'name': 'Rohan Iyer',
        'course': 'B.Tech Information Science',
        'skills': 'Dart · Maps API',
      },
    ];
    showApplicantReviewSheet(context, applicants, project['title']);
  }
}

class _ApplicantsSheet extends StatefulWidget {
  const _ApplicantsSheet({required this.project, required this.applicants});
  final Map<String, dynamic> project;
  final List<Map<String, String>> applicants;
  @override
  State<_ApplicantsSheet> createState() => _ApplicantsSheetState();
}

class _ApplicantsSheetState extends State<_ApplicantsSheet> {
  final Map<String, String> _decisions = {};
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Applicants · ${widget.project['title']}',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...widget.applicants.map(_applicantTile),
        ],
      ),
    ),
  );

  Widget _applicantTile(Map<String, String> applicant) {
    final decision = _decisions[applicant['name']];
    return Card(
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              applicant['name']!,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              applicant['course']!,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            Text(
              applicant['skills']!,
              style: const TextStyle(color: AppColors.accent, fontSize: 12),
            ),
            const SizedBox(height: 8),
            if (decision == null)
              Row(
                children: [
                  _decisionButton(
                    'Accept',
                    AppColors.accent,
                    applicant['name']!,
                  ),
                  _decisionButton(
                    'Shortlist',
                    AppColors.primary,
                    applicant['name']!,
                  ),
                  _decisionButton(
                    'Decline',
                    AppColors.textSecondary,
                    applicant['name']!,
                  ),
                ],
              )
            else
              Text(
                decision,
                style: const TextStyle(
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _decisionButton(String label, Color color, String name) => Expanded(
    child: Padding(
      padding: const EdgeInsets.only(right: 6),
      child: OutlinedButton(
        onPressed: () => setState(() => _decisions[name] = label),
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color),
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),
        child: Text(label, style: const TextStyle(fontSize: 11)),
      ),
    ),
  );
}
