import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class AlumniDashboard extends StatefulWidget {
  AlumniDashboard({super.key});
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
        [
          'Alumni Home',
          'Post Opportunity',
          'Mentorship Requests',
          'Profile',
        ][tab],
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    body: tab == 0
        ? _home()
        : tab == 1
        ? _form()
        : tab == 2
        ? _mentees()
        : _profile(),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: tab,
      onTap: (value) => setState(() => tab = value),
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.accent,
      unselectedItemColor: AppColors.textSecondary,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_business_outlined),
          label: 'Post Job',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          label: 'Mentees',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    ),
  );
  Widget _home() => ListView(
    padding: EdgeInsets.all(20),
    children: [
      Text(
        'Give back to your university community.',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 8),
      Text(
        'Share opportunities and mentor the next generation.',
        style: TextStyle(color: AppColors.textSecondary),
      ),
      SizedBox(height: 24),
      Row(
        children: [
          _stat('Opportunities', jobs.length.toString(), Icons.work_outline),
          SizedBox(width: 12),
          _stat(
            'Requests',
            mentees.length.toString(),
            Icons.handshake_outlined,
          ),
        ],
      ),
      SizedBox(height: 24),
      ...jobs.map(
        (job) => Card(
          color: AppColors.surface,
          child: ListTile(
            title: Text(
              job['title']!,
              style: TextStyle(color: AppColors.textPrimary),
            ),
            subtitle: Text(
              job['company']!,
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ),
      ),
    ],
  );
  Widget _mentees() => ListView(
    padding: EdgeInsets.all(20),
    children: [
      Text(
        'Students seeking your guidance',
        style: TextStyle(color: AppColors.textSecondary),
      ),
      SizedBox(height: 16),
      ...mentees.map(
        (mentee) => Card(
          color: AppColors.surface,
          child: ListTile(
            title: Text(
              mentee['name']!,
              style: TextStyle(color: AppColors.textPrimary),
            ),
            subtitle: Text(
              mentee['course']!,
              style: TextStyle(color: AppColors.textSecondary),
            ),
            trailing: decisions[mentee['name']] == null
                ? TextButton(
                    onPressed: () =>
                        setState(() => decisions[mentee['name']!] = 'Accepted'),
                    child: Text(
                      'Accept',
                      style: TextStyle(color: AppColors.accent),
                    ),
                  )
                : Text(
                    decisions[mentee['name']]!,
                    style: TextStyle(color: AppColors.accent),
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
        SnackBar(content: Text('Opportunity posted successfully.')),
      );
    },
  );

  Widget _profile() => ListView(
    padding: EdgeInsets.all(20),
    children: [
      CircleAvatar(
        radius: 42,
        backgroundColor: AppColors.primary,
        child: Icon(Icons.person, color: AppColors.textPrimary, size: 38),
      ),
      SizedBox(height: 14),
      Center(
        child: Text(
          'Ananya Verma',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Center(
        child: Text(
          'Product Manager · Acme Labs',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      ),
      SizedBox(height: 24),
      ListTile(
        leading: Icon(Icons.email_outlined, color: AppColors.accent),
        title: Text('Email', style: TextStyle(color: AppColors.textSecondary)),
        subtitle: Text(
          'alumni@loop.edu',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      ListTile(
        leading: Icon(Icons.school_outlined, color: AppColors.accent),
        title: Text(
          'Alma Mater',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        subtitle: Text(
          'UniLoop University · CSE 2022',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
    ],
  );
  Widget _stat(String label, String value, IconData icon) => Expanded(
    child: Container(
      padding: EdgeInsets.all(16),
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
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(label, style: TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    ),
  );
}

class _JobForm extends StatefulWidget {
  _JobForm({required this.onSubmit});
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
    padding: EdgeInsets.all(20),
    children: [
      _field(title, 'Job / Internship Title'),
      _field(company, 'Company'),
      _field(link, 'Apply Link'),
      Container(
        height: 52,
        decoration: BoxDecoration(
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
          child: Text('Post Opportunity'),
        ),
      ),
    ],
  );
  Widget _field(TextEditingController controller, String label) => Padding(
    padding: EdgeInsets.only(bottom: 16),
    child: TextField(
      controller: controller,
      style: TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.textSecondary),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    ),
  );
  void _submit() {
    if ([
      title,
      company,
      link,
    ].any((controller) => controller.text.trim().isEmpty)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please complete all fields.')));
      return;
    }
    widget.onSubmit({
      'title': title.text.trim(),
      'company': company.text.trim(),
      'link': link.text.trim(),
    });
  }
}
