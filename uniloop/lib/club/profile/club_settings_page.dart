import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class ClubSettingsPage extends StatefulWidget {
  const ClubSettingsPage({super.key});

  @override
  State<ClubSettingsPage> createState() => _ClubSettingsPageState();
}

class _ClubSettingsPageState extends State<ClubSettingsPage> {
  // Mock Website Fetching State
  bool _isFetching = false;
  bool _isSynced = false;

  // Controllers
  final _websiteController = TextEditingController(
    text: 'https://gymkhana.iiti.ac.in/',
  );
  final _aboutController = TextEditingController(
    text: 'The Technical Council of IIT Indore...',
  );
  final _newDomainController = TextEditingController();

  // Lists
  final List<String> _domains = ['Programming Club', 'Robotics Club', 'GDG'];

  // Heads
  final String _clubHead = 'Shrawan Prajapati';
  final Map<String, String> _domainHeads = {
    'Programming Club': 'Rahul Sharma',
    'GDG': 'Priya Singh',
  };

  Future<void> _syncFromWebsite() async {
    setState(() => _isFetching = true);

    // Fake delay to simulate API fetch
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isFetching = false;
      _isSynced = true;
      // Fake data fetched from website
      _aboutController.text =
          'Fetched from Gymkhana: The Technical Council fosters innovation through coding, robotics, and tech events.';
      _domains.addAll(['Astronomy Club', 'Coding Club']);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data synced from website successfully!'),
        backgroundColor: AppColors.accent,
      ),
    );
  }

  void _addDomain() {
    if (_newDomainController.text.isNotEmpty) {
      setState(() {
        _domains.add(_newDomainController.text.trim());
        _newDomainController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text(
          'Club Settings',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. WEBSITE & SYNC SECTION
            _buildSectionTitle('Website & Sync'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _websiteController,
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: _inputDecoration(
                      'Club Website URL',
                      Icons.link,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isFetching ? null : _syncFromWebsite,
                      icon: _isFetching
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.sync, color: Colors.white),
                      label: Text(
                        _isFetching
                            ? 'Fetching Data...'
                            : 'Fetch Data from Website',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  if (_isSynced) ...[
                    const SizedBox(height: 8),
                    const Text(
                      'Last synced: Just now',
                      style: TextStyle(color: AppColors.accent, fontSize: 12),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 2. ABOUT SECTION
            _buildSectionTitle('About Club'),
            TextField(
              controller: _aboutController,
              maxLines: 4,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: _inputDecoration(
                'Club Description / Highlights',
                null,
              ),
            ),
            const SizedBox(height: 30),

            // 3. CLUB HEAD SECTION
            _buildSectionTitle('Club Head'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(
                  _clubHead,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Change',
                    style: TextStyle(color: AppColors.accent),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // 4. DOMAINS SECTION
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionTitle('Domains & Heads'),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: AppColors.accent),
                  onPressed: () => _showAddDomainDialog(),
                ),
              ],
            ),
            ..._domains.map((domain) => _buildDomainCard(domain)),

            const SizedBox(height: 40),

            // SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Club Settings Saved!'),
                      backgroundColor: AppColors.accent,
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Save All Changes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDomainCard(String domainName) {
    String? head = _domainHeads[domainName];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                domainName,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                  size: 20,
                ),
                onPressed: () {
                  setState(() => _domains.remove(domainName));
                },
              ),
            ],
          ),
          const Divider(color: Colors.white12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orangeAccent, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'Head: ${head ?? "Not Assigned"}',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => _showAssignHeadDialog(domainName),
                child: Text(
                  head == null ? 'Assign Head' : 'Change Head',
                  style: const TextStyle(color: AppColors.accent, fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData? icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.textSecondary),
      prefixIcon: icon != null
          ? Icon(icon, color: AppColors.textSecondary)
          : null,
      filled: true,
      fillColor: AppColors.background,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  void _showAddDomainDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: const Text(
            'Add New Domain',
            style: TextStyle(color: AppColors.textPrimary),
          ),
          content: TextField(
            controller: _newDomainController,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: _inputDecoration('e.g., Web Dev Club', null),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _addDomain();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text('Add', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showAssignHeadDialog(String domainName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            'Assign Head for $domainName',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 18),
          ),
          content: const TextField(
            style: TextStyle(color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Enter Student Name or ID',
              hintStyle: TextStyle(color: AppColors.textSecondary),
              filled: true,
              fillColor: AppColors.background,
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Save logic
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text(
                'Assign',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
