import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class AlumniDashboard extends StatefulWidget {
  const AlumniDashboard({super.key});
  @override
  State<AlumniDashboard> createState() => _AlumniDashboardState();
}

class _AlumniDashboardState extends State<AlumniDashboard> {
  int tab = 0;
  final jobs = <Map<String, String>>[
    {
      'title': 'Product Design Intern',
      'company': 'Acme Labs',
      'link': 'https://acme.example/jobs',
    },
  ];
  final mentees = <Map<String, String>>[
    {'name': 'Riya Kapoor', 'course': 'Computer Science · Final Year'},
    {'name': 'Kabir Singh', 'course': 'Information Systems · Third Year'},
  ];
  final decisions = <String, String>{};
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    appBar: AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      title: Text(
        ['Alumni Home', 'Post Opportunity', 'Mentorship Requests'][tab],
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    body: tab == 0
        ? _home()
        : tab == 1
        ? _form()
        : _mentees(),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: tab,
      onTap: (value) => setState(() => tab = value),
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.accent,
      unselectedItemColor: AppColors.textSecondary,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_business_outlined),
          label: 'Post Job',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          label: 'Mentees',
        ),
      ],
    ),
  );
  Widget _home() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Text(
        'Give back to your university community.',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        'Share opportunities and mentor the next generation.',
        style: TextStyle(color: AppColors.textSecondary),
      ),
      const SizedBox(height: 24),
      Row(
        children: [
          _stat('Opportunities', jobs.length.toString(), Icons.work_outline),
          const SizedBox(width: 12),
          _stat(
            'Requests',
            mentees.length.toString(),
            Icons.handshake_outlined,
          ),
        ],
      ),
      const SizedBox(height: 24),
      ...jobs.map(
        (job) => Card(
          color: AppColors.surface,
          child: ListTile(
            title: Text(
              job['title']!,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
            subtitle: Text(
              job['company']!,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ),
      ),
    ],
  );
  Widget _mentees() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Text(
        'Students seeking your guidance',
        style: TextStyle(color: AppColors.textSecondary),
      ),
      const SizedBox(height: 16),
      ...mentees.map(
        (mentee) => Card(
          color: AppColors.surface,
          child: ListTile(
            title: Text(
              mentee['name']!,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
            subtitle: Text(
              mentee['course']!,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            trailing: decisions[mentee['name']] == null
                ? TextButton(
                    onPressed: () =>
                        setState(() => decisions[mentee['name']!] = 'Accepted'),
                    child: const Text(
                      'Accept',
                      style: TextStyle(color: AppColors.accent),
                    ),
                  )
                : Text(
                    decisions[mentee['name']]!,
                    style: const TextStyle(color: AppColors.accent),
                  ),
          ),
        ),
      ),
    ],
  );
  Widget _form() => _JobForm(
    onSubmit: (job) {
      setState(() {
        jobs.add(job);
        tab = 0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Opportunity posted successfully.')),
      );
    },
  );
  Widget _stat(String label, String value, IconData icon) => Expanded(
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
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    ),
  );
}

class _JobForm extends StatefulWidget {
  const _JobForm({required this.onSubmit});
  final ValueChanged<Map<String, String>> onSubmit;
  @override
  State<_JobForm> createState() => _JobFormState();
}

class _JobFormState extends State<_JobForm> {
  final title = TextEditingController(),
      company = TextEditingController(),
      link = TextEditingController();
  @override
  void dispose() {
    title.dispose();
    company.dispose();
    link.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      _field(title, 'Job / Internship Title'),
      _field(company, 'Company'),
      _field(link, 'Apply Link'),
      Container(
        height: 52,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.accent],
          ),
        ),
        child: ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: AppColors.textPrimary,
          ),
          child: const Text('Post Opportunity'),
        ),
      ),
    ],
  );
  Widget _field(TextEditingController controller, String label) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: TextField(
      controller: controller,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        filled: true,
        fillColor: AppColors.surface,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    ),
  );
  void _submit() {
    if ([
      title,
      company,
      link,
    ].any((controller) => controller.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields.')),
      );
      return;
    }
    widget.onSubmit({
      'title': title.text.trim(),
      'company': company.text.trim(),
      'link': link.text.trim(),
    });
  }
}
