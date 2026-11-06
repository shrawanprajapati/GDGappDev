import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ClubDetailPage extends StatelessWidget {
  final Map<String, dynamic> clubData;
  const ClubDetailPage({super.key, required this.clubData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header Section (Logo & Name)
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: clubData['color'].withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(clubData['icon'], color: clubData['color'], size: 40),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clubData['name'],
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${clubData['category']} • ${clubData['members']}',
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // 2. Common Highlights (Maintained by Club Head)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Common Highlights',
                        style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We build projects, host hackathons, and help students get industry-ready.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 3. Find Project Section
            const Text(
              'Explore Opportunities',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            
            // Find Project Button (Based on screenshot)
            InkWell(
              onTap: () {
                // TODO: Navigate to Project List Page
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary.withValues(alpha: 0.8), AppColors.accent.withValues(alpha: 0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    )
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Find Project', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Project for induction & Industrial', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 4. Domains / Sub-Clubs (e.g., GDG, P Club)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Different Domains',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text('View all', style: TextStyle(color: AppColors.accent, fontSize: 14)),
              ],
            ),
            const SizedBox(height: 12),
            
            Row(
              children: [
                _buildDomainChip('GDG'),
                const SizedBox(width: 12),
                _buildDomainChip('P Club'),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDomainChip(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Text(
        title,
        style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
      ),
    );
  }
}