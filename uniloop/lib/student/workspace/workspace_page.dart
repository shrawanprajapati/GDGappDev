import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/data/mock_store.dart';
import 'project_history_page.dart';

class WorkspacePage extends StatefulWidget {
  final Map<String, dynamic> projectData;
  WorkspacePage({super.key, required this.projectData});

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Dummy Tasks
  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'Design Landing Page UI',
      'assignedTo': 'You',
      'status': 'Done',
      'due': 'Today',
    },
    {
      'title': 'Setup Flutter Project',
      'assignedTo': 'Rahul',
      'status': 'Done',
      'due': 'Yesterday',
    },
    {
      'title': 'Integrate Google Maps API',
      'assignedTo': 'You',
      'status': 'In Progress',
      'due': 'Tomorrow',
    },
    {
      'title': 'Write Documentation',
      'assignedTo': 'Amit',
      'status': 'Pending',
      'due': '25 Oct',
    },
  ];

  // Dummy Milestones
  final List<Map<String, dynamic>> milestones = [
    {
      'title': 'UI/UX Prototype Submission',
      'status': 'Approved',
      'feedback': 'Great design, loved the dark theme!',
    },
    {
      'title': 'MVP Development',
      'status': 'Pending Review',
      'feedback': 'Submitted on time.',
    },
    {'title': 'Final Deployment', 'status': 'Upcoming', 'feedback': ''},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          'Workspace',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProjectHistoryPage(
                  projectTitle: widget.projectData['title'],
                ),
              ),
            ),
            icon: Icon(Icons.history, color: AppColors.textPrimary),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.accent,
          labelColor: AppColors.accent,
          unselectedLabelColor: AppColors.textSecondary,
          tabs: [
            Tab(text: 'Project Tasks'),
            Tab(text: 'Milestones'),
            Tab(text: 'Kanban'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // --- TAB 1: TASKS & TEAM ---
          SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.projectData['title'],
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 16,
                      color: Colors.orangeAccent,
                    ),
                    SizedBox(width: 6),
                    Text(
                      widget.projectData['deadline'],
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                OutlinedButton.icon(
                  onPressed: _showReportIssueSheet,
                  icon: Icon(Icons.report_problem_outlined),
                  label: Text('Report Issue'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.accent,
                    side: BorderSide(color: AppColors.accent),
                  ),
                ),
                SizedBox(height: 30),

                Text(
                  'Team Members',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    _buildAvatar('You', AppColors.primary),
                    SizedBox(width: 12),
                    _buildAvatar('Rahul', Colors.blueAccent),
                    SizedBox(width: 12),
                    _buildAvatar('Amit', Colors.orangeAccent),
                    SizedBox(width: 12),
                    _buildAvatar('Priya', Colors.pinkAccent),
                  ],
                ),

                SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tasks',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _showAddTaskSheet,
                      icon: Icon(Icons.add, size: 16, color: AppColors.accent),
                      label: Text(
                        'Add',
                        style: TextStyle(color: AppColors.accent, fontSize: 13),
                      ),
                    ),
                  ],
                ),
                ...tasks.map((task) => _buildTaskCard(task)),
              ],
            ),
          ),

          // --- TAB 2: MILESTONES ---
          ListView.builder(
            padding: EdgeInsets.all(20.0),
            itemCount: milestones.length,
            itemBuilder: (context, index) {
              final milestone = milestones[index];
              return _buildMilestoneCard(context, milestone);
            },
          ),
          _buildKanbanBoard(),
        ],
      ),
      // Chat Floating Action Button
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'add-task',
            onPressed: _showAddTaskSheet,
            backgroundColor: AppColors.accent,
            foregroundColor: AppColors.background,
            icon: Icon(Icons.add_task),
            label: Text('Add Task'),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'discussion',
            onPressed: () => _showDiscussionThread(context),
            backgroundColor: AppColors.primary,
            child: Icon(Icons.forum, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String name, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: color.withValues(alpha: 0.2),
          child: Text(
            name[0],
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 4),
        Text(
          name,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 11),
        ),
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
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 24),
          SizedBox(width: 16),
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
                    decoration: task['status'] == 'Done'
                        ? TextDecoration.lineThrough
                        : null,
                    decorationColor: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Assigned to: ${task['assignedTo']} • Due: ${task['due']}',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKanbanBoard() {
    final columns = ['To Do', 'In Progress', 'Review', 'Done'];
    return ListView(
      padding: EdgeInsets.all(16),
      scrollDirection: Axis.horizontal,
      children: columns.map((column) {
        final cards = tasks
            .where(
              (task) => column == 'To Do'
                  ? task['status'] == 'Pending'
                  : column == 'In Progress'
                  ? task['status'] == 'In Progress'
                  : column == 'Review'
                  ? task['status'] == 'Review'
                  : task['status'] == 'Done',
            )
            .toList();
        return Container(
          width: 250,
          margin: EdgeInsets.only(right: 12),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                column,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              if (cards.isEmpty)
                Text(
                  'No tasks',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ...cards.map((task) {
                final priority = task['priority'] ?? 'Medium';
                final color = priority == 'High'
                    ? AppColors.primary
                    : priority == 'Low'
                    ? AppColors.textSecondary
                    : AppColors.accent;
                return Card(
                  color: AppColors.background,
                  child: ListTile(
                    title: Text(
                      task['title'],
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                    subtitle: Text(
                      '${task['assignedTo']} · ${task['due']}',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                    trailing: Text(
                      priority,
                      style: TextStyle(color: color, fontSize: 10),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMilestoneCard(
    BuildContext context,
    Map<String, dynamic> milestone,
  ) {
    Color statusColor;
    if (milestone['status'] == 'Approved') {
      statusColor = AppColors.accent;
    } else if (milestone['status'] == 'Pending Review') {
      statusColor = Colors.orangeAccent;
    } else {
      statusColor = AppColors.textSecondary;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                milestone['title'],
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  milestone['status'],
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (milestone['feedback'].toString().isNotEmpty) ...[
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.feedback_outlined,
                    color: AppColors.textSecondary,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Client Feedback: "${milestone['feedback']}"',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < 4 ? Icons.star : Icons.star_border,
                              color: AppColors.accent,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (milestone['status'] == 'Upcoming') ...[
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _showSubmitMilestoneSheet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surface,
                  foregroundColor: AppColors.textPrimary,
                  side: BorderSide(color: AppColors.textPrimary.withValues(alpha: 0.12)),
                ),
                child: Text('Submit Deliverable'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showAddTaskSheet() {
    final titleController = TextEditingController();
    String assignee = 'You';
    String priority = 'Medium';
    DateTime? dueDate;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: titleController,
                style: TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  labelStyle: TextStyle(color: AppColors.textSecondary),
                ),
              ),
              DropdownButtonFormField<String>(
                initialValue: assignee,
                dropdownColor: AppColors.surface,
                style: TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  labelText: 'Assign To',
                  labelStyle: TextStyle(color: AppColors.textSecondary),
                ),
                items: ['You', 'Rahul', 'Amit', 'Priya']
                    .map(
                      (name) =>
                          DropdownMenuItem(value: name, child: Text(name)),
                    )
                    .toList(),
                onChanged: (value) => setSheetState(() => assignee = value!),
              ),
              DropdownButtonFormField<String>(
                initialValue: priority,
                dropdownColor: AppColors.surface,
                style: TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  labelText: 'Priority',
                  labelStyle: TextStyle(color: AppColors.textSecondary),
                ),
                items: ['High', 'Medium', 'Low']
                    .map(
                      (value) =>
                          DropdownMenuItem(value: value, child: Text(value)),
                    )
                    .toList(),
                onChanged: (value) => setSheetState(() => priority = value!),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  dueDate == null
                      ? 'Choose Due Date'
                      : '${dueDate!.day}/${dueDate!.month}/${dueDate!.year}',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
                leading: Icon(Icons.calendar_today, color: AppColors.accent),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    initialDate: DateTime.now(),
                  );
                  if (picked != null) setSheetState(() => dueDate = picked);
                },
              ),
              SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (titleController.text.trim().isEmpty) return;
                    final newTask = {
                      'title': titleController.text.trim(),
                      'assignedTo': assignee,
                      'status': 'Pending',
                      'due': dueDate == null
                          ? 'Not set'
                          : '${dueDate!.day}/${dueDate!.month}',
                      'priority': priority,
                    };
                    setState(() => tasks.add(newTask));
                    MockStore.instance.addTask(newTask);
                    Navigator.pop(sheetContext);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textPrimary,
                  ),
                  child: Text('Create Task'),
                ),
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(titleController.dispose);
  }

  void _showSubmitMilestoneSheet() {
    final controller = TextEditingController();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Submit Milestone',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 14),
            TextField(
              controller: controller,
              maxLines: 4,
              style: TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Paste GitHub link or add submission notes',
                hintStyle: TextStyle(color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.background,
              ),
            ),
            SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.text.trim().isEmpty) return;
                  final milestone = {
                    'title': 'Workspace milestone',
                    'status': 'Pending Review',
                    'submission': controller.text.trim(),
                  };
                  setState(
                    () => milestones.firstWhere(
                      (item) => item['status'] == 'Upcoming',
                    )['status'] = 'Pending Review',
                  );
                  MockStore.instance.addMilestone(milestone);
                  Navigator.pop(sheetContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Milestone submitted for review.')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textPrimary,
                ),
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    ).whenComplete(controller.dispose);
  }

  void _showReportIssueSheet() {
    final controller = TextEditingController();
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
              'Report an Issue',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 14),
            TextField(
              controller: controller,
              maxLines: 4,
              style: TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Describe the issue',
                hintStyle: TextStyle(color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.background,
              ),
            ),
            SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.text.trim().isEmpty) return;
                  MockStore.instance.addReport({
                    'type': 'Workspace Issue',
                    'description': controller.text.trim(),
                    'status': 'Pending',
                  });
                  Navigator.pop(sheetContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Issue reported to the project team.'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textPrimary,
                ),
                child: Text('Send Report'),
              ),
            ),
          ],
        ),
      ),
    ).whenComplete(controller.dispose);
  }

  // --- CHAT / DISCUSSION THREAD ---
  void _showDiscussionThread(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColors.textPrimary.withValues(alpha: 0.12))),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.forum, color: AppColors.accent),
                      SizedBox(width: 12),
                      Text(
                        'Team Discussion',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.close, color: AppColors.textSecondary),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),

                // Messages
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(20),
                    children: [
                      _buildChatMessage(
                        'Rahul',
                        'Hey team, I finished the Flutter project setup.',
                        false,
                      ),
                      _buildChatMessage(
                        'You',
                        'Great! I am working on the Google Maps API now.',
                        true,
                      ),
                      _buildChatMessage(
                        'Priya',
                        'Let me know if you need help with the UI design.',
                        false,
                      ),
                    ],
                  ),
                ),

                // Input
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: TextField(
                            style: TextStyle(color: AppColors.textPrimary),
                            decoration: InputDecoration(
                              hintText: 'Type a message...',
                              hintStyle: TextStyle(
                                color: AppColors.textSecondary,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: IconButton(
                          icon: Icon(Icons.send, color: Colors.white, size: 20),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatMessage(String sender, String message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(maxWidth: 250),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: isMe ? Radius.circular(0) : Radius.circular(16),
            bottomLeft: isMe ? Radius.circular(16) : Radius.circular(0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe)
              Text(
                sender,
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            SizedBox(height: 4),
            Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : AppColors.textPrimary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


