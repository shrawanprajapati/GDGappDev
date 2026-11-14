import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_theme.dart';
import '../drawer/student_drawer.dart';
import '../teams/student_teams_tab.dart';
import 'student_home_tab.dart';
import 'notification_page.dart'; // 👈 Notification Page import kiya
import '../marketplace/marketplace_tab.dart';
import 'loop_ai_tab.dart';

class StudentDashboard extends StatefulWidget {
  StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _currentIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _tabs = [
    StudentHomeTab(),
    StudentTeamsTab(),
    MarketplaceTab(),
    LoopAiTab(),
    Center(
      child: Text(
        'Marketplace coming soon',
        style: TextStyle(color: AppColors.textPrimary),
      ),
    ),
    Center(
      child: Text(
        'Loop AI coming soon',
        style: TextStyle(color: AppColors.textPrimary),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppTheme.settings,
      builder: (context, _) {
        AppTheme.syncCurrentColors();
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: AppColors.background,
          drawer: StudentDrawer(),

          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.menu, color: AppColors.textPrimary),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            title: Text(
              'UniLoop',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 24,
                letterSpacing: 1.2,
              ),
            ),
            actions: [
              // 👈 Search Icon (Bottom Sheet ke saath)
              IconButton(
                icon: Icon(Icons.search, color: AppColors.textPrimary),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: AppColors.surface,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 20,
                          right: 20,
                          top: 20,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextField(
                                autofocus: true,
                                style: TextStyle(color: AppColors.textPrimary),
                                decoration: InputDecoration(
                                  hintText: 'Search events, projects, clubs...',
                                  hintStyle: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                  border: InputBorder.none,
                                  icon: Icon(
                                    Icons.search,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),

              // 👈 Notification Icon (Naya Page)
              IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  color: AppColors.textPrimary,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationPage()),
                  );
                },
              ),
              SizedBox(width: 8),
            ],
          ),

          body: _tabs[_currentIndex],

          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border(
                top: BorderSide(
                  color: AppColors.textPrimary.withValues(alpha: 0.08),
                ),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.accent,
              unselectedItemColor: AppColors.textSecondary,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              unselectedLabelStyle: TextStyle(fontSize: 12),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people_outline),
                  activeIcon: Icon(Icons.people),
                  label: 'Teams',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.storefront_outlined),
                  activeIcon: Icon(Icons.storefront),
                  label: 'Marketplace',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.auto_awesome_outlined),
                  activeIcon: Icon(Icons.auto_awesome),
                  label: 'Loop AI',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
