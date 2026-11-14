import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_routes.dart';
import '../club/dashboard/club_dashboard.dart';
import '../professor/dashboard/professor_dashboard.dart';
import 'signup_page.dart'; // 👈 Naya import add kiya

class UniversityLoginPage extends StatefulWidget {
  UniversityLoginPage({super.key});

  @override
  State<UniversityLoginPage> createState() => _UniversityLoginPageState();
}

class _UniversityLoginPageState extends State<UniversityLoginPage> {
  String? _selectedRole;
  bool _obscureText = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<String> _roles = [
    'Student',
    'Professor',
    'Club',
    'Alumni',
    'Admin',
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_selectedRole == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select your role')));
      return;
    }

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    if (_selectedRole == 'Student') {
      Navigator.pushReplacementNamed(context, AppRoutes.studentDashboard);
    } else if (_selectedRole == 'Club') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ClubDashboard()),
      );
    } else if (_selectedRole == 'Professor') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfessorDashboard()),
      );
    } else if (_selectedRole == 'Industry/Company') {
      Navigator.pushReplacementNamed(context, AppRoutes.industryDashboard);
    } else if (_selectedRole == 'Admin') {
      Navigator.pushReplacementNamed(context, AppRoutes.adminDashboard);
    } else if (_selectedRole == 'Alumni') {
      Navigator.pushReplacementNamed(context, AppRoutes.alumniDashboard);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$_selectedRole login coming soon!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'University Login',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 30),

              _buildDropdown(),
              SizedBox(height: 20),

              _buildTextField(
                controller: _emailController,
                hint: 'University Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),

              _buildTextField(
                controller: _passwordController,
                hint: 'Password',
                icon: Icons.lock_outline,
                obscureText: _obscureText,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: AppColors.accent, fontSize: 14),
                  ),
                ),
              ),
              SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: AppColors.brandGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.45),
                        blurRadius: 24,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColors.textSecondary.withValues(alpha: 0.3),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: AppColors.textSecondary.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: AppColors.textSecondary.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.g_mobiledata,
                    size: 32,
                    color: AppColors.textPrimary,
                  ),
                  label: Text(
                    'Continue with Google',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: AppColors.textPrimary.withValues(alpha: 0.18),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              // 👈 Yahan Signup ka link add kiya hai
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New here? ",
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to Signup Page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                      child: Text(
                        "Create an account",
                        style: TextStyle(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.08)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedRole,
          hint: Text(
            'Select your role',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          dropdownColor: AppColors.surface,
          icon: Icon(Icons.arrow_drop_down, color: AppColors.textSecondary),
          isExpanded: true,
          items: _roles.map((String role) {
            return DropdownMenuItem<String>(
              value: role,
              child: Text(role, style: TextStyle(color: AppColors.textPrimary)),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedRole = newValue;
            });
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.08)),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.textSecondary),
          prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}


