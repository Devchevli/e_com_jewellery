import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jewellery/core/theme/app_imports.dart';
import 'package:jewellery/core/widgets/custom_text.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _zoomController;

  @override
  void initState() {
    super.initState();
    _zoomController = AnimationController(vsync: this, duration: const Duration(seconds: 12))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _zoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// Background Image Slow Zoom
          AnimatedBuilder(
            animation: _zoomController,
            builder: (context, child) {
              double scale = 1 + (_zoomController.value * 0.05);
              return Transform.scale(
                scale: scale,
                child: Image.asset(CustomAssets.onboardingOne, fit: BoxFit.cover),
              );
            },
          ),

          /// Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, CustomColor.appSecondaryColor.withOpacity(0.8)],
              ),
            ),
          ),

          /// Subtle Light Sweep
          Positioned.fill(
            child: IgnorePointer(
              child:
                  Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, Color(0x22F4C025), Colors.transparent],
                            begin: Alignment(-1, -0.3),
                            end: Alignment(1, 0.3),
                          ),
                        ),
                      )
                      .animate(onPlay: (c) => c.repeat())
                      .moveX(begin: -300, end: 300, duration: 6.seconds),
            ),
          ),

          /// Text Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),

                /// Calligraphy Headline
                CustomText(
                  "Eternal",
                  fontSize: 48,
                  font: GoogleFonts.greatVibes,
                  gradient: const LinearGradient(colors: [Color(0xffFFF7AD), Color(0xffF4C025)]),
                ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3),

                const SizedBox(height: 12),

                /// Subtitle (Manrope)
                const CustomText(
                  "Crafted to define presence.",
                  fontSize: 16,
                  color: Colors.white70,
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
