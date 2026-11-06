import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class HiringPipelinePage extends StatefulWidget {
  const HiringPipelinePage({super.key});

  @override
  State<HiringPipelinePage> createState() => _HiringPipelinePageState();
}

class _HiringPipelinePageState extends State<HiringPipelinePage> {
  final stages = [
    'New',
    'Screening',
    'Shortlisted',
    'Interview',
    'Selected',
    'Offer Sent',
    'Hired',
  ];
  final candidates = <Map<String, dynamic>>[
    {'name': 'Aarav Mehta', 'stage': 'New', 'skills': 'Flutter · Firebase'},
    {
      'name': 'Priya Sharma',
      'stage': 'Screening',
      'skills': 'UX Research · Figma',
    },
    {'name': 'Rohan Iyer', 'stage': 'Shortlisted', 'skills': 'Dart · Maps API'},
    {'name': 'Kabir Singh', 'stage': 'Interview', 'skills': 'Python · NLP'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Hiring Pipeline',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        scrollDirection: Axis.horizontal,
        children: stages.map(_stageColumn).toList(),
      ),
    );
  }

  Widget _stageColumn(String stage) {
    final items = candidates
        .where((candidate) => candidate['stage'] == stage)
        .toList();
    return Container(
      width: 230,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stage,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          if (items.isEmpty)
            const Text(
              'No candidates',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ...items.map(_candidateCard),
        ],
      ),
    );
  }

  Widget _candidateCard(Map<String, dynamic> candidate) => Card(
    color: AppColors.background,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            candidate['name'],
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            candidate['skills'],
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButton<String>(
            isExpanded: true,
            value: candidate['stage'],
            dropdownColor: AppColors.surface,
            style: const TextStyle(color: AppColors.accent, fontSize: 12),
            items: stages
                .map(
                  (stage) => DropdownMenuItem(value: stage, child: Text(stage)),
                )
                .toList(),
            onChanged: (stage) {
              if (stage != null) setState(() => candidate['stage'] = stage);
            },
          ),
        ],
      ),
    ),
  );
}
