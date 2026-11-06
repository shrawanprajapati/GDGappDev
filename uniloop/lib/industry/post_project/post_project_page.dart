import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class PostProjectPage extends StatefulWidget {
  const PostProjectPage({super.key});
  @override
  State<PostProjectPage> createState() => _PostProjectPageState();
}

class _PostProjectPageState extends State<PostProjectPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _skillsController = TextEditingController();
  final _budgetController = TextEditingController();
  final _timelineController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _skillsController.dispose();
    _budgetController.dispose();
    _timelineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    appBar: AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      title: const Text(
        'Post a Project',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    body: Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Share an opportunity with talented university students.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          _field(
            _titleController,
            'Project Title',
            'e.g. Campus Mobility Platform',
          ),
          _field(
            _descriptionController,
            'Description',
            'What should the team build?',
            maxLines: 4,
          ),
          _field(
            _skillsController,
            'Required Skills',
            'e.g. Flutter, UX Research, APIs',
          ),
          Row(
            children: [
              Expanded(
                child: _field(
                  _budgetController,
                  'Budget',
                  'e.g. ₹50,000',
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _field(_timelineController, 'Timeline', 'e.g. 8 weeks'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.publish),
              label: const Text('Publish Project'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _field(
    TextEditingController controller,
    String label,
    String hint, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.textPrimary),
      validator: (value) =>
          value == null || value.trim().isEmpty ? 'Required' : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: AppColors.accent),
        ),
      ),
    ),
  );

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(context, {
      'title': _titleController.text.trim(),
      'description': _descriptionController.text.trim(),
      'skills': _skillsController.text
          .split(',')
          .map((skill) => skill.trim())
          .where((skill) => skill.isNotEmpty)
          .toList(),
      'budget': _budgetController.text.trim(),
      'timeline': _timelineController.text.trim(),
      'applicants': 0,
      'status': 'Active',
    });
  }
}
