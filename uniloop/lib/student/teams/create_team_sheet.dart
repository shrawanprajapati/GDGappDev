import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class CreateTeamSheet extends StatefulWidget {
  const CreateTeamSheet({super.key});

  @override
  State<CreateTeamSheet> createState() => _CreateTeamSheetState();
}

class _CreateTeamSheetState extends State<CreateTeamSheet> {
  String selectedDept = 'Any';
  String selectedYear = 'Any';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20, 
        left: 20, 
        right: 20, 
        top: 20
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Create New Team', style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          
          // Team Name
          _buildInputField('Team Name (e.g., CodeCrafters)'),
          const SizedBox(height: 12),
          
          // Project Target
          _buildInputField('Target Project (e.g., SIH 2024)'),
          const SizedBox(height: 12),

          // Skills Required
          _buildInputField('Required Skills (comma separated)'),
          const SizedBox(height: 16),

          // Dropdowns for Dept & Year
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedDept,
                      dropdownColor: AppColors.surface,
                      icon: const Icon(Icons.arrow_drop_down, color: AppColors.textSecondary),
                      isExpanded: true,
                      items: ['Any', 'CSE', 'ECE', 'Mech', 'Civil'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text('Dept: $value', style: const TextStyle(color: AppColors.textPrimary, fontSize: 14)),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() => selectedDept = newValue!);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedYear,
                      dropdownColor: AppColors.surface,
                      icon: const Icon(Icons.arrow_drop_down, color: AppColors.textSecondary),
                      isExpanded: true,
                      items: ['Any', '1st Year', '2nd Year', '3rd Year', '4th Year'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle(color: AppColors.textPrimary, fontSize: 14)),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() => selectedYear = newValue!);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Team Created Successfully!'), backgroundColor: AppColors.accent),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Create Team', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildInputField(String hint) {
    return TextField(
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}