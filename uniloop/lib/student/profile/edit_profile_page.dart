import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/data/mock_store.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _aboutController;
  late TextEditingController _githubController;
  late TextEditingController _linkedinController;

  late List<String> _skills;
  late List<String> _interests;
  late List<String> _clubs;
  late List<String> _achievements;
  late List<Map<String, dynamic>> _projects;

  final _addSkillCtrl = TextEditingController();
  final _addInterestCtrl = TextEditingController();
  final _addClubCtrl = TextEditingController();
  final _addAchievementCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final student = MockStore.instance.currentUser;

    _nameController = TextEditingController(text: student?['name'] ?? '');
    _bioController = TextEditingController(text: student?['bio'] ?? '');
    _aboutController = TextEditingController(text: student?['about'] ?? '');
    _githubController = TextEditingController(text: student?['github'] ?? '');
    _linkedinController = TextEditingController(
      text: student?['linkedin'] ?? '',
    );

    _skills = List<String>.from(student?['skills'] ?? []);
    _interests = List<String>.from(student?['interests'] ?? []);
    _clubs = List<String>.from(student?['clubs'] ?? []);
    _achievements = List<String>.from(student?['achievements'] ?? []);
    _projects = List<Map<String, dynamic>>.from(student?['projects'] ?? []);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _aboutController.dispose();
    _githubController.dispose();
    _linkedinController.dispose();
    _addSkillCtrl.dispose();
    _addInterestCtrl.dispose();
    _addClubCtrl.dispose();
    _addAchievementCtrl.dispose();
    super.dispose();
  }

  void _saveProfile() {
    MockStore.instance.updateCurrentUser({
      'name': _nameController.text,
      'bio': _bioController.text,
      'about': _aboutController.text,
      'github': _githubController.text,
      'linkedin': _linkedinController.text,
      'skills': _skills,
      'interests': _interests,
      'clubs': _clubs,
      'achievements': _achievements,
      'projects': _projects,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile Updated Successfully!'),
        backgroundColor: AppColors.accent,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: Text(
              'Save',
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Basic Info'),
            _buildTextField(_nameController, 'Full Name', Icons.person_outline),
            SizedBox(height: 12),
            _buildTextField(
              _bioController,
              'Bio (Course, Year, College)',
              Icons.info_outline,
            ),
            SizedBox(height: 12),
            _buildTextField(
              _aboutController,
              'About Me (Short bio)',
              Icons.description,
              maxLines: 3,
            ),

            SizedBox(height: 24),
            _buildSectionTitle('Social Links'),
            _buildTextField(
              _githubController,
              'GitHub URL (e.g., github.com/username)',
              Icons.code,
            ),
            SizedBox(height: 12),
            _buildTextField(
              _linkedinController,
              'LinkedIn URL (e.g., linkedin.com/in/username)',
              Icons.work_outline,
            ),

            SizedBox(height: 24),
            _buildSectionTitle('Skills'),
            _buildDynamicStringList(_skills, _addSkillCtrl, 'Add a new skill'),

            SizedBox(height: 24),
            _buildSectionTitle('Projects'),
            ..._projects.map(
              (p) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  p['title'] ?? '',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
                subtitle: Text(
                  p['desc'] ?? '',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () => setState(() => _projects.remove(p)),
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () => _showAddProjectDialog(),
              icon: Icon(Icons.add, color: AppColors.accent),
              label: Text(
                'Add Project',
                style: TextStyle(color: AppColors.accent),
              ),
            ),

            SizedBox(height: 24),
            _buildSectionTitle('Clubs & Councils'),
            _buildDynamicStringList(_clubs, _addClubCtrl, 'Add a club name'),

            SizedBox(height: 24),
            _buildSectionTitle('Achievements'),
            _buildDynamicStringList(
              _achievements,
              _addAchievementCtrl,
              'Add an achievement',
            ),

            SizedBox(height: 24),
            _buildSectionTitle('Interests'),
            _buildDynamicStringList(
              _interests,
              _addInterestCtrl,
              'Add an interest',
            ),

            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.textSecondary),
        prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  Widget _buildDynamicStringList(
    List<String> list,
    TextEditingController ctrl,
    String hint,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: list
              .map(
                (item) => Chip(
                  label: Text(
                    item,
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                  backgroundColor: AppColors.surface,
                  deleteIcon: Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.redAccent,
                  ),
                  onDeleted: () => setState(() => list.remove(item)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: AppColors.textPrimary.withValues(alpha: 0.12)),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildTextField(ctrl, hint, Icons.add)),
            SizedBox(width: 12),
            IconButton(
              onPressed: () {
                if (ctrl.text.isNotEmpty) {
                  setState(() {
                    list.add(ctrl.text.trim());
                    ctrl.clear();
                  });
                }
              },
              icon: Icon(Icons.check_circle, color: AppColors.accent, size: 32),
            ),
          ],
        ),
      ],
    );
  }

  void _showAddProjectDialog() {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final techCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          'Add Project',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(titleCtrl, 'Project Title', Icons.title),
            SizedBox(height: 8),
            _buildTextField(descCtrl, 'Short Description', Icons.description),
            SizedBox(height: 8),
            _buildTextField(techCtrl, 'Tech Stack (e.g., Flutter)', Icons.code),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _projects.add({
                  'title': titleCtrl.text,
                  'desc': descCtrl.text,
                  'tech': techCtrl.text,
                });
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}


