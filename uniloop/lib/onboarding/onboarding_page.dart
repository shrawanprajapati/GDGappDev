import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../core/app_colors.dart';
import '../core/app_routes.dart'; // Import add kiya

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  static const String _appName = 'Uniloop';
  static const String _slogan = 'Your University,\nYour Loop';
  static const String _subtitle = 'CONNECT · DISCOVER · BELONG';
  static const String _ctaLabel = 'Get Started';
  static const String _skipLabel = 'Skip for now';
  static const List<String> _chips = ['Events', 'Clubs', 'Students', 'Professors'];

  late final VideoPlayerController _video;
  late final AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _video = VideoPlayerController.asset('assets/videos/onboarding_video.mp4')
      ..initialize().then((_) {
        _video
          ..setLooping(true)
          ..setVolume(0)
          ..play();
        if (mounted) setState(() {});
      });

    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
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
                stops: const [0.0, 0.45, 1.0],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 20, 28, 28),
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
                          decoration: const BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
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
                    const Spacer(flex: 3),
                    // Slogan
                    const Text(
                      _slogan,
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        height: 1.15,
                        letterSpacing: -0.5,
                        shadows: [
                          Shadow(offset: Offset(0, 2), blurRadius: 12, color: Colors.black54),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      _subtitle,
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.textSecondary,
                        letterSpacing: 3.0,
                      ),
                    ),
                    const Spacer(flex: 2),
                    // Feature chips
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _chips.map((label) => _Chip(label: label)).toList(),
                    ),
                    const SizedBox(height: 28),
                    // Get Started Button
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: const LinearGradient(
                            colors: [AppColors.primary, AppColors.accent],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.45),
                              blurRadius: 24,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, AppRoutes.login);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
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
                          Navigator.pushReplacementNamed(context, AppRoutes.login);
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
  const _Chip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.textPrimary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.15)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}