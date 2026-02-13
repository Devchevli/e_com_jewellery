import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jewellery/core/theme/app_imports.dart';
import 'package:jewellery/core/widgets/custom_scroll.dart';
import 'section_title.dart';

class LimitedDropSection extends StatefulWidget {
  const LimitedDropSection({super.key});

  @override
  State<LimitedDropSection> createState() => _LimitedDropSectionState();
}

class _LimitedDropSectionState extends State<LimitedDropSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _zoomController;

  @override
  void initState() {
    super.initState();
    _zoomController = AnimationController(vsync: this, duration: const Duration(seconds: 8))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _zoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ScrollReveal(
        beginOffset: const Offset(0, 0.1),
        duration: const Duration(milliseconds: 1200),

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 140),
          child: Column(
            children: [
              CustomText(
                "LIMITED",

                letterSpacing: 6,
                fontSize: 14,
                color: CustomColor.yellowPrimary,
                fontWeight: FontWeight.w400,
              ).animate().fadeIn(duration: 1000.ms).slideY(begin: 0.2),

              const SizedBox(height: 60),

              /// Centered rare image with breathing zoom
              AnimatedBuilder(
                animation: _zoomController,
                builder: (context, child) {
                  double scale = 1 + (_zoomController.value * 0.04);
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: CustomColor.yellowPrimary.withOpacity(0.15),
                            blurRadius: 80,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(CustomAssets.onboardingOne, fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 60),

              CustomText(
                "Signature Rare Collection",

                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),

              const SizedBox(height: 12),

              CustomText(
                "Only 12 crafted worldwide",
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
              ).animate().fadeIn(delay: 600.ms),

              const SizedBox(height: 30),

              CustomText(
                "₹ 24,999",

                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: CustomColor.yellowPrimary,
              ).animate().fadeIn(delay: 800.ms),
            ],
          ),
        ),
      ),
    );
  }
}
