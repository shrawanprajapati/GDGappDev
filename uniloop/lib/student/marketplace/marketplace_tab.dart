import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../projects/find_project_page.dart'; // Direct projects pe le jane ke liye

class MarketplaceTab extends StatelessWidget {
  const MarketplaceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Marketplace',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Explore projects, clubs merchandise, and student services.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 24),

          // Categories
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCategoryCard(
                context,
                title: 'Projects',
                icon: Icons.work_outline,
                color: AppColors.primary,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FindProjectPage(),
                    ),
                  );
                },
              ),
              _buildCategoryCard(
                context,
                title: 'Merch',
                icon: Icons.shopping_bag_outlined,
                color: Colors.orangeAccent,
                onTap: () {
                  // TODO: Merch Page
                },
              ),
              _buildCategoryCard(
                context,
                title: 'Services',
                icon: Icons.handyman_outlined,
                color: AppColors.accent,
                onTap: () {
                  // TODO: Services Page
                },
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Featured Section
          const Text(
            'Featured Items',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),

          // Grid of items
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
            children: [
              _buildMarketplaceCard(
                title: 'GDG Official Hoodie',
                price: '₹899',
                seller: 'GDG Club',
                icon: Icons.checkroom,
                color: Colors.blueAccent,
              ),
              _buildMarketplaceCard(
                title: 'Flutter App Template',
                price: '₹499',
                seller: 'Rahul (CSE)',
                icon: Icons.code,
                color: AppColors.primary,
              ),
              _buildMarketplaceCard(
                title: 'Calculus Notes (PDF)',
                price: '₹99',
                seller: 'Priya (Math)',
                icon: Icons.menu_book,
                color: Colors.greenAccent,
              ),
              _buildMarketplaceCard(
                title: 'Resume Review',
                price: 'Free',
                seller: 'Alumni Network',
                icon: Icons.description,
                color: Colors.orangeAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketplaceCard({
    required String title,
    required String price,
    required String seller,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            seller,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: const TextStyle(
              color: AppColors.accent,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
