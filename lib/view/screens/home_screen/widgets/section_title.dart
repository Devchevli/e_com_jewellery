import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jewellery/core/theme/app_imports.dart';
import 'package:jewellery/core/widgets/custom_text.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionTitle({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.75),
          ).animate().fadeIn(duration: 900.ms, curve: Curves.easeOutCubic).slideY(begin: 0.2),

          const SizedBox(height: 6),

          CustomText(subtitle, fontSize: 14, color: Colors.white70).animate().fadeIn(delay: 200.ms),
        ],
      ),
    );
  }
}
