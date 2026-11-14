import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../core/app_colors.dart';
import '../core/app_routes.dart'; // Import add kiya

class OnboardingPage extends StatefulWidget {
  OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  static String _appName = 'Uniloop';
  static String _slogan = 'Your University,\nYour Loop';
  static String _subtitle = 'CONNECT · DISCOVER · BELONG';
  static String _ctaLabel = 'Get Started';
  static String _skipLabel = 'Skip for now';
  static List<String> _chips = ['Events', 'Clubs', 'Students', 'Professors'];

  late final VideoPlayerController _video;
  late final AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _video = VideoPlayerController.asset('assets/videos/onboarding_video.mp4');
    _initializeVideo();

    _anim = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..forward();
  }

  Future<void> _initializeVideo() async {
    try {
      await _video.initialize();
      await _video.setLooping(true);
      await _video.setVolume(0);
      await _video.play();
      if (mounted) setState(() {});
    } catch (_) {
      // The onboarding remains usable when video playback is unavailable.
    }
  }

  @override
  void dispose() {
    _video.dispose();
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Video Background (Fixed Fit)
          if (_video.value.isInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _video.value.size.width,
                  height: _video.value.size.height,
                  child: VideoPlayer(_video),
                ),
              ),
            ),

          // Gradient Scrim
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.75),
                  Colors.black.withValues(alpha: 0.15),
                  Colors.black.withValues(alpha: 0.85),
                ],
                stops: [0.0, 0.45, 1.0],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(28, 20, 28, 28),
              child: FadeTransition(
                opacity: _anim,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          _appName,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    Spacer(flex: 3),
                    // Slogan
                    Text(
                      _slogan,
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        height: 1.15,
                        letterSpacing: -0.5,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 2),
                            blurRadius: 12,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      _subtitle,
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.textSecondary,
                        letterSpacing: 3.0,
                      ),
                    ),
                    Spacer(flex: 2),
                    // Feature chips
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _chips
                          .map((label) => _Chip(label: label))
                          .toList(),
                    ),
                    SizedBox(height: 28),
                    // Get Started Button
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
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.login,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: Text(
                            _ctaLabel,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Skip
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.login,
                          );
                        },
                        child: Text(
                          _skipLabel,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary.withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  _Chip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.textPrimary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.textPrimary.withValues(alpha: 0.15),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
