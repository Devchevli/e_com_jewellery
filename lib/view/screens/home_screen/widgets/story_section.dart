import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jewellery/core/theme/app_imports.dart';
import 'package:jewellery/core/widgets/custom_text.dart';
import 'package:jewellery/view/screens/home_screen/widgets/gold_divider.dart';

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jewellery/core/theme/app_imports.dart';
import 'package:jewellery/core/widgets/custom_text.dart';

class StorySection extends StatefulWidget {
  final String headline;
  final String paragraph;

  const StorySection({super.key, required this.headline, required this.paragraph});

  @override
  State<StorySection> createState() => _StorySectionState();
}

class _StorySectionState extends State<StorySection> with SingleTickerProviderStateMixin {
  double x = 0;
  double y = 0;
  late AnimationController particleController;

  @override
  void initState() {
    super.initState();
    particleController = AnimationController(vsync: this, duration: const Duration(seconds: 6))
      ..repeat();
  }

  @override
  void dispose() {
    particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
        },
        onPanUpdate: (details) {
          setState(() {
            x = (details.localPosition.dx - 150) / 150;
            y = (details.localPosition.dy - 100) / 100;
          });
        },
        onPanEnd: (_) {
          setState(() {
            x = 0;
            y = 0;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(y * 0.04)
            ..rotateY(x * -0.04),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: CustomColor.appPrimaryColor,
            boxShadow: [
              BoxShadow(
                color: CustomColor.yellowPrimary.withOpacity(0.25),
                blurRadius: 60,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Stack(
            children: [
              /// Depth blur layer
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(color: Colors.transparent),
                  ),
                ),
              ),

              /// Particle dust
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: particleController,
                  builder: (_, __) {
                    return CustomPaint(painter: ParticlePainter(particleController.value));
                  },
                ),
              ),

              /// Moving highlight
              Positioned.fill(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    gradient: RadialGradient(
                      center: Alignment(x, y),
                      radius: 1.4,
                      colors: [CustomColor.yellowPrimary.withOpacity(0.15), Colors.transparent],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 90),
                child: Column(
                  children: [
                    /// Shimmer headline
                    CustomText(
                          widget.headline,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                        )
                        .animate(onPlay: (c) => c.repeat())
                        .shimmer(
                          duration: 4.seconds,
                          color: CustomColor.yellowLight.withOpacity(0.4),
                        ),

                    const SizedBox(height: 30),

                    CustomText(
                      widget.paragraph,
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.85),
                      lineHeight: 1.8,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final double progress;
  ParticlePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = CustomColor.yellowPrimary.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    final random = Random(1);

    for (int i = 0; i < 25; i++) {
      final dx = random.nextDouble() * size.width;
      final dy = (random.nextDouble() * size.height + progress * 50) % size.height;

      canvas.drawCircle(Offset(dx, dy), 1.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
