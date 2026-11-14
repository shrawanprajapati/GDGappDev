import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/data/mock_store.dart';

class RemindersPage extends StatefulWidget {
  RemindersPage({super.key});
  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  final reminders = <Map<String, dynamic>>[
    {
      'title': 'Submit Workspace Milestone',
      'detail': 'Campus Mobility Platform',
      'date': 'Today · 8:00 PM',
      'done': false,
      'kind': 'Project',
    },
    {
      'title': 'Complete GDG application form',
      'detail': 'Technical Club induction',
      'date': 'Tomorrow · 11:59 PM',
      'done': false,
      'kind': 'Form',
    },
    {
      'title': 'Attend Academic Office briefing',
      'detail': 'Academic Block · Room 101',
      'date': 'Friday · 4:00 PM',
      'done': false,
      'kind': 'Campus',
    },
  ];

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: MockStore.instance,
    builder: (context, _) => Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'My Reminders',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textPrimary,
        onPressed: _addReminder,
        icon: Icon(Icons.add_alarm),
        label: Text('Add Reminder'),
      ),
      body: [...reminders, ...MockStore.instance.reminders].isEmpty
          ? Center(
              child: Text(
                'No reminders yet',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          : ListView(
              padding: EdgeInsets.all(20),
              children: [
                Text(
                  'Deadlines, forms, and campus commitments in one place.',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                SizedBox(height: 20),
                ...[
                  ...reminders,
                  ...MockStore.instance.reminders,
                ].map(_reminderTile),
              ],
            ),
    ),
  );

  Widget _reminderTile(Map<String, dynamic> reminder) => Card(
    color: AppColors.surface,
    margin: EdgeInsets.only(bottom: 12),
    child: ListTile(
      onTap: () => setState(() => reminder['done'] = !reminder['done']),
      leading: CircleAvatar(
        backgroundColor: reminder['kind'] == 'Form'
            ? AppColors.accent.withValues(alpha: .18)
            : AppColors.primary.withValues(alpha: .18),
        child: Icon(
          reminder['kind'] == 'Form'
              ? Icons.assignment_outlined
              : Icons.event_note_outlined,
          color: reminder['kind'] == 'Form'
              ? AppColors.accent
              : AppColors.primary,
        ),
      ),
      title: Text(
        reminder['title'],
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          decoration: reminder['done'] ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Text(
        '${reminder['detail']}\n${reminder['date']}',
        style: TextStyle(color: AppColors.textSecondary),
      ),
      isThreeLine: true,
      trailing: Icon(
        reminder['done'] ? Icons.check_circle : Icons.radio_button_unchecked,
        color: reminder['done'] ? AppColors.accent : AppColors.textSecondary,
      ),
    ),
  );

  void _addReminder() {
    final title = TextEditingController();
    final detail = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add a reminder',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _field(title, 'What should you remember?'),
            _field(detail, 'Details or deadline'),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (title.text.trim().isEmpty) return;
                  MockStore.instance.addReminder({
                    'title': title.text.trim(),
                    'detail': detail.text.trim().isEmpty
                        ? 'Personal reminder'
                        : detail.text.trim(),
                    'date': 'Added just now',
                    'done': false,
                    'kind': 'Personal',
                  });
                  Navigator.pop(sheetContext);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textPrimary,
                ),
                child: Text('Save Reminder'),
              ),
            ),
          ],
        ),
      ),
    ).whenComplete(() {
      title.dispose();
      detail.dispose();
    });
  }

  Widget _field(TextEditingController controller, String hint) => Padding(
    padding: EdgeInsets.only(bottom: 12),
    child: TextField(
      controller: controller,
      style: TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.textSecondary),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    ),
  );
}
