// lib/core/role_search_delegate.dart
import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../role_data/role_data.dart';

/// A reusable search delegate that works on any list of [SearchItem]s.
class RoleSearchDelegate extends SearchDelegate<String> {
  RoleSearchDelegate({
    required this.roleName, // for UI header (e.g. "Club", "Student")
    required this.items, // the complete list for the role
  });

  final String roleName;
  final List<SearchItem> items;

  // -----------------------------------------------------------------
  // UI appearance (same for all roles)
  // -----------------------------------------------------------------
  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context).copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.textSecondary),
    ),
  );

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(onPressed: () => query = '', icon: Icon(Icons.clear)),
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    onPressed: () => close(context, ''),
    icon: Icon(Icons.arrow_back),
  );

  // -----------------------------------------------------------------
  // Core filtering logic – case‑insensitive, matches title or subtitle
  // -----------------------------------------------------------------
  List<SearchItem> _filtered() {
    if (query.isEmpty) return [];
    final lower = query.toLowerCase();
    return items.where((i) {
      return i.title.toLowerCase().contains(lower) ||
          i.subtitle.toLowerCase().contains(lower);
    }).toList();
  }

  // -----------------------------------------------------------------
  // Show the same UI for suggestions (while typing) and final results
  // -----------------------------------------------------------------
  @override
  Widget buildResults(BuildContext context) => _buildResultList(context);
  @override
  Widget buildSuggestions(BuildContext context) => _buildResultList(context);

  // -----------------------------------------------------------------
  // Build the scrolling list of matches
  // -----------------------------------------------------------------
  Widget _buildResultList(BuildContext context) {
    final results = _filtered();

    if (query.isEmpty) {
      return Center(
        child: Text(
          'Search $roleName events, members, projects…',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }
    if (results.isEmpty) {
      return Center(
        child: Text(
          'No $roleName results for “$query”',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.all(8),
      itemCount: results.length,
      separatorBuilder: (context, index) => Divider(height: 1),
      itemBuilder: (ctx, i) {
        final item = results[i];
        // Choose an icon based on the item type – feel free to expand
        IconData icon;
        switch (item.type.toLowerCase()) {
          case 'event':
            icon = Icons.event;
            break;
          case 'member':
            icon = Icons.person;
            break;
          case 'project':
            icon = Icons.work;
            break;
          case 'complaint':
            icon = Icons.report_problem;
            break;
          case 'notification':
            icon = Icons.notifications;
            break;
          case 'news':
            icon = Icons.article;
            break;
          case 'job':
            icon = Icons.business_center;
            break;
          case 'opportunity':
            icon = Icons.school;
            break;
          default:
            icon = Icons.help_outline;
        }

        return ListTile(
          leading: Icon(icon, color: AppColors.textPrimary),
          title: Text(
            item.title,
            style: TextStyle(color: AppColors.textPrimary),
          ),
          subtitle: Text(
            item.subtitle,
            style: TextStyle(color: AppColors.textSecondary),
          ),
          onTap: () {
            // TODO: navigate to a detail page using `item.id` and `item.type`
            close(context, item.title); // simple close for now
          },
        );
      },
    );
  }
}
