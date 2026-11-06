import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'alumni_profile_page.dart';

class AlumniListPage extends StatelessWidget {
  const AlumniListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Alumni Data
    final alumniList = [
      {
        'name': 'Rahul Sharma',
        'company': 'Google',
        'role': 'SDE-2',
        'batch': 'B.Tech CSE • 2019',
        'domain': 'Software Engineering',
        'image': 'https://i.pravatar.cc/150?img=11',
      },
      {
        'name': 'Priya Singh',
        'company': 'Microsoft',
        'role': 'Product Manager',
        'batch': 'B.Tech IT • 2020',
        'domain': 'Product Management',
        'image': 'https://i.pravatar.cc/150?img=5',
      },
      {
        'name': 'Amit Patel',
        'company': 'Goldman Sachs',
        'role': 'Quant Analyst',
        'batch': 'B.Tech Mech • 2018',
        'domain': 'Finance & Analytics',
        'image': 'https://i.pravatar.cc/150?img=3',
      },
      {
        'name': 'Sneha Reddy',
        'company': 'Amazon',
        'role': 'Data Scientist',
        'batch': 'B.Tech ECE • 2021',
        'domain': 'Data Science',
        'image': 'https://i.pravatar.cc/150?img=9',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text(
          'Connect Alumni',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              child: const TextField(
                style: TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search by company or domain...',
                  hintStyle: TextStyle(color: AppColors.textSecondary),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.textSecondary,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),

          // Alumni List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: alumniList.length,
              itemBuilder: (context, index) {
                final alumni = alumniList[index];
                return _buildAlumniCard(context, alumni);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlumniCard(BuildContext context, Map<String, dynamic> alumni) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlumniProfilePage(alumniData: alumni),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          children: [
            // Profile Image
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(alumni['image']),
              backgroundColor: AppColors.background,
            ),
            const SizedBox(width: 16),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alumni['name'],
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${alumni['role']} at ${alumni['company']}',
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    alumni['batch'],
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
