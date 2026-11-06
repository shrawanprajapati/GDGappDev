import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class WorkspacePage extends StatefulWidget {
  final Map<String, dynamic> projectData;
  const WorkspacePage({super.key, required this.projectData});

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {
  // Dummy Tasks
  final List<Map<String, dynamic>> tasks = [
    {'title': 'Design Landing Page UI', 'assignedTo': 'You', 'status': 'Done', 'due': 'Today'},
    {'title': 'Setup Flutter Project', 'assignedTo': 'Rahul', 'status': 'Done', 'due': 'Yesterday'},
    {'title': 'Integrate Google Maps API', 'assignedTo': 'You', 'status': 'In Progress', 'due': 'Tomorrow'},
    {'title': 'Write Documentation', 'assignedTo': 'Amit', 'status': 'Pending', 'due': '25 Oct'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text('Workspace', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, color: AppColors.accent),
            onPressed: () {
              // TODO: Discussion Thread
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Header
            Text(
              widget.projectData['title'],
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.timer_outlined, size: 16, color: Colors.orangeAccent),
                const SizedBox(width: 6),
                Text(widget.projectData['deadline'], style: const TextStyle(color: Colors.orangeAccent, fontSize: 13, fontWeight: FontWeight.bold)),
              ],
            ),
            
            const SizedBox(height: 30),

            // Team Members Section
            const Text('Team Members', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildAvatar('You', AppColors.primary),
                const SizedBox(width: 12),
                _buildAvatar('Rahul', Colors.blueAccent),
                const SizedBox(width: 12),
                _buildAvatar('Amit', Colors.orangeAccent),
                const SizedBox(width: 12),
                _buildAvatar('Priya', Colors.pinkAccent),
              ],
            ),

            const SizedBox(height: 30),

            // Tasks Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Project Tasks', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton.icon(
                  onPressed: () {
                    // TODO: Add Task
                  },
                  icon: const Icon(Icons.add, size: 16, color: AppColors.accent),
                  label: const Text('Add Task', style: TextStyle(color: AppColors.accent, fontSize: 13)),
                )
              ],
            ),
            const SizedBox(height: 8),
            
            ...tasks.map((task) => _buildTaskCard(task)),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String name, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: color.withValues(alpha: 0.2),
          child: Text(name[0], style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
      ],
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    Color statusColor;
    IconData statusIcon;
    
    if (task['status'] == 'Done') {
      statusColor = AppColors.accent;
      statusIcon = Icons.check_circle;
    } else if (task['status'] == 'In Progress') {
      statusColor = Colors.orangeAccent;
      statusIcon = Icons.timelapse;
    } else {
      statusColor = AppColors.textSecondary;
      statusIcon = Icons.radio_button_unchecked;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task['title'],
                  style: TextStyle(
                    color: AppColors.textPrimary, 
                    fontSize: 15, 
                    fontWeight: FontWeight.w600,
                    decoration: task['status'] == 'Done' ? TextDecoration.lineThrough : null,
                    decorationColor: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Assigned to: ${task['assignedTo']} • Due: ${task['due']}', 
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}