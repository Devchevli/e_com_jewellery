import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GoldDivider extends StatelessWidget {
  const GoldDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: 60,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xffF4C025), Color(0xffB8860B)]),
      ),
    ).animate().scaleX(begin: 0, duration: 700.ms, curve: Curves.easeOut);
  }
}
