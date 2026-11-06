import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class StudentEventsPage extends StatefulWidget {
  const StudentEventsPage({super.key});

  @override
  State<StudentEventsPage> createState() => _StudentEventsPageState();
}

class _StudentEventsPageState extends State<StudentEventsPage> {
  // Filter state
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Technical', 'Cultural', 'Sports'];

  // Dummy Data for Events
  final List<Map<String, dynamic>> _events = [
    {
      'title': 'IIT BHU Induction',
      'subtitle': 'Mandatory for all 1st years',
      'date': 'Aug 10, 2024',
      'time': '10:00 AM',
      'location': 'Main Auditorium',
      'category': 'Technical',
      'isOngoing': true,
      'color': AppColors.primary,
    },
    {
      'title': 'Tech Fest 2024',
      'subtitle': 'Annual Tech & Innovation Summit',
      'date': 'Oct 24, 2024',
      'time': '09:00 AM',
      'location': 'Main Audi',
      'category': 'Technical',
      'isOngoing': false,
      'color': AppColors.accent,
    },
    {
      'title': 'Spandan (Cultural)',
      'subtitle': 'Dance, Drama & Music',
      'date': 'Nov 12, 2024',
      'time': '05:00 PM',
      'location': 'Open Air Theatre',
      'category': 'Cultural',
      'isOngoing': false,
      'color': Colors.pinkAccent,
    },
    {
      'title': 'Inter-College Hackathon',
      'subtitle': '36-hour coding challenge',
      'date': 'Sep 05, 2024',
      'time': '08:00 AM',
      'location': 'CS Lab 2',
      'category': 'Technical',
      'isOngoing': false,
      'color': Colors.orangeAccent,
    },
    {
      'title': 'Sports Meet',
      'subtitle': 'Annual Athletics Meet',
      'date': 'Dec 01, 2024',
      'time': '07:00 AM',
      'location': 'Sports Ground',
      'category': 'Sports',
      'isOngoing': false,
      'color': Colors.greenAccent,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter logic
    final filteredEvents = _selectedFilter == 'All'
        ? _events
        : _events.where((e) => e['category'] == _selectedFilter).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text(
          'Campus Events',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Column(
        children: [
          // Category Filters
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                      backgroundColor: AppColors.surface,
                      selectedColor: AppColors.primary.withValues(alpha: 0.2),
                      labelStyle: TextStyle(
                        color: isSelected ? AppColors.primary : AppColors.textSecondary,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                      side: BorderSide(
                        color: isSelected ? AppColors.primary : Colors.white.withValues(alpha: 0.05),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  );
                },
              ),
            ),
          ),

          // Events List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final event = filteredEvents[index];
                return _buildEventCard(context, event);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, Map<String, dynamic> event) {
    return GestureDetector(
      onTap: () => _showEventDetails(context, event),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: event['isOngoing'] 
                ? AppColors.primary.withValues(alpha: 0.5) 
                : Colors.white.withValues(alpha: 0.05),
          ),
          boxShadow: [
            if (event['isOngoing'])
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: event['color'].withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      event['category'],
                      style: TextStyle(color: event['color'], fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (event['isOngoing'])
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 6),
                        const Text('Live', style: TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                event['title'],
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                event['subtitle'],
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 6),
                  Text(event['date'], style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  const SizedBox(width: 16),
                  const Icon(Icons.location_on_outlined, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      event['location'], 
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Modal Bottom Sheet for Details
  void _showEventDetails(BuildContext context, Map<String, dynamic> event) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              Text(
                event['title'],
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                event['subtitle'],
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 16),
              ),
              const SizedBox(height: 24),
              
              _buildDetailRow(Icons.calendar_today_outlined, '${event['date']} • ${event['time']}'),
              const SizedBox(height: 16),
              _buildDetailRow(Icons.location_on_outlined, event['location']),
              const SizedBox(height: 16),
              _buildDetailRow(Icons.group_outlined, 'Open to all students'),
              
              const SizedBox(height: 32),
              
              // Action Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(colors: [AppColors.primary, AppColors.accent]),
                  ),
                  

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close bottom sheet
                        // Show Success Message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Successfully Registered for ${event['title']}!'),
                            backgroundColor: AppColors.accent,
                          ),
                        );
                      },
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(
                      event['isOngoing'] ? 'Fill Induction Form' : 'Register Now',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accent, size: 20),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(color: AppColors.textPrimary, fontSize: 15)),
      ],
    );
  }
}