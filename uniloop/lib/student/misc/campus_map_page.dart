import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class CampusMapPage extends StatefulWidget {
  CampusMapPage({super.key});
  @override
  State<CampusMapPage> createState() => _CampusMapPageState();
}

class _CampusMapPageState extends State<CampusMapPage> {
  String selected = 'Library';
  final places = <Map<String, dynamic>>[
    {
      'name': 'Library',
      'icon': Icons.local_library_outlined,
      'detail': 'Central Library · Open until 10:00 PM',
    },
    {
      'name': 'Main Canteen',
      'icon': Icons.restaurant_outlined,
      'detail': 'Food court · 5 min walk',
    },
    {
      'name': 'CSE Department',
      'icon': Icons.science_outlined,
      'detail': 'Academic block · Rooms 101–220',
    },
    {
      'name': 'Innovation Lab',
      'icon': Icons.biotech_outlined,
      'detail': 'Project workspace · Ground floor',
    },
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    appBar: AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      title: Text(
        'Campus Map',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    body: ListView(
      padding: EdgeInsets.all(20),
      children: [
        Container(
          height: 260,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary.withValues(alpha: .4)),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.map_outlined, color: AppColors.accent, size: 100),
              Positioned(
                top: 35,
                left: 55,
                child: _pin(Icons.local_library_outlined, 'Library'),
              ),
              Positioned(
                bottom: 42,
                right: 45,
                child: _pin(Icons.restaurant_outlined, 'Canteen'),
              ),
              Positioned(
                bottom: 55,
                left: 80,
                child: _pin(Icons.science_outlined, 'CSE'),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Explore Campus',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        ...places.map(
          (place) => Card(
            color: AppColors.surface,
            child: ListTile(
              onTap: () => setState(() => selected = place['name']),
              leading: Icon(
                place['icon'],
                color: place['name'] == selected
                    ? AppColors.accent
                    : AppColors.textSecondary,
              ),
              title: Text(
                place['name'],
                style: TextStyle(color: AppColors.textPrimary),
              ),
              subtitle: Text(
                place['detail'],
                style: TextStyle(color: AppColors.textSecondary),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ],
    ),
  );
  Widget _pin(IconData icon, String label) => Column(
    children: [
      Icon(icon, color: AppColors.accent, size: 28),
      Text(label, style: TextStyle(color: AppColors.textPrimary, fontSize: 11)),
    ],
  );
}
