import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController(text: 'Shrawan Prajapati');
  final _bioController = TextEditingController(text: 'B.Tech CSE • 2nd Year • IIT Indore');
  final _githubController = TextEditingController(text: 'github.com/shrawan');
  final _linkedinController = TextEditingController(text: 'linkedin.com/in/shrawan');

  // Skills list (State)
  final List<String> _skills = ['Flutter', 'Dart', 'Python', 'UI/UX Design'];
  final _newSkillController = TextEditingController();

  // Interests list (State)
  final List<String> _interests = ['Internship (Summer 2025)', 'Open Source Projects'];
  final _newInterestController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _githubController.dispose();
    _linkedinController.dispose();
    _newSkillController.dispose();
    _newInterestController.dispose();
    super.dispose();
  }

  void _addSkill() {
    if (_newSkillController.text.isNotEmpty) {
      setState(() {
        _skills.add(_newSkillController.text.trim());
        _newSkillController.clear();
      });
    }
  }

  void _addInterest() {
    if (_newInterestController.text.isNotEmpty) {
      setState(() {
        _interests.add(_newInterestController.text.trim());
        _newInterestController.clear();
      });
    }
  }

  void _saveProfile() {
    // TODO: Save to Database/API
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile Updated Successfully!'), backgroundColor: AppColors.accent),
    );
    Navigator.pop(context); // Go back to Profile Page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text('Edit Profile', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Photo Section
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 3),
                      image: const DecorationImage(
                        image: NetworkImage('https://i.pravatar.cc/300?img=11'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Image Picker
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                        child: const Icon(Icons.camera_alt, size: 18, color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Basic Info
            _buildSectionTitle('Basic Info'),
            _buildTextField(_nameController, 'Full Name', Icons.person_outline),
            const SizedBox(height: 12),
            _buildTextField(_bioController, 'Bio (Course, Year, College)', Icons.info_outline),
            
            const SizedBox(height: 24),

            // Social Links
            _buildSectionTitle('Social Links'),
            _buildTextField(_githubController, 'GitHub URL', Icons.code),
            const SizedBox(height: 12),
            _buildTextField(_linkedinController, 'LinkedIn URL', Icons.work_outline),

            const SizedBox(height: 24),

            // Skills Section
            _buildSectionTitle('Skills'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _skills.map((skill) => _buildEditableChip(skill, _skills)).toList(),
            ),
            const SizedBox(height: 12),
            _buildAddField(_newSkillController, 'Add new skill', _addSkill),

            const SizedBox(height: 24),

            // Interests Section
            _buildSectionTitle('Interests & Job Preferences'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _interests.map((interest) => _buildEditableChip(interest, _interests)).toList(),
            ),
            const SizedBox(height: 12),
            _buildAddField(_newInterestController, 'Add new interest (e.g., Internship)', _addInterest),

            const SizedBox(height: 40),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Save Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary)),
      ),
    );
  }

  Widget _buildAddField(TextEditingController controller, String hint, VoidCallback onAdd) {
    return Row(
      children: [
        Expanded(child: _buildTextField(controller, hint, Icons.add)),
        const SizedBox(width: 12),
        IconButton(
          onPressed: onAdd,
          icon: const Icon(Icons.check_circle, color: AppColors.accent, size: 32),
        )
      ],
    );
  }

  Widget _buildEditableChip(String label, List<String> list) {
    return Chip(
      label: Text(label, style: const TextStyle(color: AppColors.textPrimary)),
      backgroundColor: AppColors.surface,
      deleteIcon: const Icon(Icons.close, size: 16, color: Colors.redAccent),
      onDeleted: () {
        setState(() {
          list.remove(label);
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Colors.white12),
      ),
    );
  }
}