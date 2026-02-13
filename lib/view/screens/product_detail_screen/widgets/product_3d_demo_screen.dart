import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jewellery/core/theme/app_imports.dart';

class RoyalStageDemoScreen extends StatefulWidget {
  const RoyalStageDemoScreen({super.key});

  @override
  State<RoyalStageDemoScreen> createState() => RoyalStageDemoScreenState();
}

class RoyalStageDemoScreenState extends State<RoyalStageDemoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(seconds: 4));

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          double reveal = controller.value;

          return Stack(
            children: [
              /// Deep Royal Background
              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.2,
                    colors: [const Color(0xFF0A0904), Colors.black],
                  ),
                ),
              ),

              /// Golden Ambient Glow
              Opacity(
                opacity: reveal * 0.6,
                child: Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [CustomColor.yellowPrimary.withOpacity(0.15), Colors.transparent],
                      ),
                    ),
                  ),
                ),
              ),

              /// Spotlight Beam
              Align(
                alignment: Alignment.topCenter,
                child: Opacity(
                  opacity: reveal * 0.8,
                  child: Container(
                    height: 400,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [CustomColor.yellowLight.withOpacity(0.15), Colors.transparent],
                      ),
                    ),
                  ),
                ),
              ),

              /// Necklace Reveal
              Center(
                child: Opacity(
                  opacity: Curves.easeOut.transform(reveal),
                  child: Transform.translate(
                    offset: Offset(0, sin(reveal * pi) * 8),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(sin(reveal * pi) * 0.05),
                      child: Image.asset(CustomAssets.chain, width: 280),
                    ),
                  ),
                ),
              ),

              /// Reflection
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.22,
                left: 0,
                right: 0,
                child: Opacity(
                  opacity: reveal * 0.15,
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white.withOpacity(0.4), Colors.transparent],
                      ).createShader(bounds);
                    },

                    blendMode: BlendMode.dstIn,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..scale(1.0, -1.0, 1.0),
                      child: Image.asset(CustomAssets.chain, width: 280),
                    ),
                  ),
                ),
              ),

              /// Limited Drop Label
              Positioned(
                top: 80,
                left: 24,
                child: Opacity(
                  opacity: reveal,
                  child: Text(
                    "Limited Drop",
                    style: TextStyle(
                      color: CustomColor.yellowPrimary,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
