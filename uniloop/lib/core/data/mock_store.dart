import 'package:flutter/foundation.dart';

class MockStore extends ChangeNotifier {
  MockStore._();
  static final MockStore instance = MockStore._();

  final users = <Map<String, dynamic>>[
    {
      'id': 'student-1',
      'name': 'Shrawan Prajapati',
      'email': 'student@loop.edu',
      'role': 'Student',
      'skills': ['Flutter', 'Dart', 'UI/UX'],
    },
    {
      'id': 'student-2',
      'name': 'Priya Sharma',
      'email': 'priya@loop.edu',
      'role': 'Student',
      'skills': ['Figma', 'Research'],
    },
    {
      'id': 'club-1',
      'name': 'GDG Technical Club',
      'email': 'club@loop.edu',
      'role': 'Club',
      'skills': ['Events', 'Technology'],
    },
    {
      'id': 'prof-1',
      'name': 'Dr. A. Sharma',
      'email': 'prof@loop.edu',
      'role': 'Professor',
      'skills': ['AI', 'Research'],
    },
    {
      'id': 'alumni-1',
      'name': 'Ananya Verma',
      'email': 'alumni@loop.edu',
      'role': 'Alumni',
      'skills': ['Product', 'Mentorship'],
    },
    {
      'id': 'company-1',
      'name': 'Acme Labs',
      'email': 'industry@company.com',
      'role': 'Industry',
      'skills': ['Mobile', 'AI'],
    },
    {
      'id': 'admin-1',
      'name': 'UniLoop Admin',
      'email': 'admin@loop.edu',
      'role': 'Admin',
      'skills': [],
    },
  ];

  final projects = <Map<String, dynamic>>[
    {
      'id': 'project-1',
      'title': 'Campus Mobility Platform',
      'postedBy': 'Acme Labs',
      'status': 'Open',
      'domain': 'Mobile',
      'skills': ['Flutter', 'Maps'],
      'budget': '₹80,000',
    },
    {
      'id': 'project-2',
      'title': 'AI Resume Coach',
      'postedBy': 'Dr. A. Sharma',
      'status': 'In Progress',
      'domain': 'AI',
      'skills': ['Python', 'NLP'],
      'budget': 'Academic Credit',
    },
    {
      'id': 'project-3',
      'title': 'GDG Portfolio Challenge',
      'postedBy': 'GDG Technical Club',
      'status': 'Closed',
      'domain': 'Web',
      'skills': ['React', 'Design'],
      'budget': 'Induction Task',
    },
  ];
  final teams = <Map<String, dynamic>>[
    {
      'id': 'team-1',
      'name': 'Vishwakarma Award Team',
      'members': ['student-1', 'student-2'],
      'skills': ['Flutter', 'Dart', 'UI/UX'],
    },
  ];
  final applications = <Map<String, dynamic>>[];
  final tasks = <Map<String, dynamic>>[];
  final milestones = <Map<String, dynamic>>[];
  final notifications = <Map<String, dynamic>>[];
  final reports = <Map<String, dynamic>>[];

  void addNotification({
    required String userId,
    required String type,
    required String text,
    String? route,
  }) {
    notifications.insert(0, {
      'id': DateTime.now().microsecondsSinceEpoch.toString(),
      'userId': userId,
      'type': type,
      'text': text,
      'route': route,
      'read': false,
    });
    notifyListeners();
  }

  int unreadCount(String userId) => notifications
      .where((item) => item['userId'] == userId && item['read'] == false)
      .length;
  void markAllRead(String userId) {
    for (final item in notifications.where(
      (item) => item['userId'] == userId,
    )) {
      item['read'] = true;
    }
    notifyListeners();
  }

  void addProject(Map<String, dynamic> project) {
    projects.insert(0, project);
    notifyListeners();
  }

  void addReport(Map<String, dynamic> report) {
    reports.add(report);
    notifyListeners();
  }

  void addApplication(Map<String, dynamic> application) {
    applications.add(application);
    notifyListeners();
  }

  void addTask(Map<String, dynamic> task) {
    tasks.add(task);
    notifyListeners();
  }

  void addMilestone(Map<String, dynamic> milestone) {
    milestones.add(milestone);
    notifyListeners();
  }
}
