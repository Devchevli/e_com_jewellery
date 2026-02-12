import 'dart:async';
import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {
  late AnimationController logoController;
  late AnimationController textController;
  late AnimationController lineController;
  late AnimationController shimmerController;
  late AnimationController bgPulseController;
  late AnimationController particleController;

  String typedText = '';
  final String fullText = 'INITIALIZING 3D ATELIER';

  void init(TickerProvider vsync) {
    logoController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1200),
    );

    textController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1200),
    );

    lineController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1000),
    );

    shimmerController = AnimationController(vsync: vsync, duration: const Duration(seconds: 2))
      ..repeat();

    bgPulseController = AnimationController(vsync: vsync, duration: const Duration(seconds: 3))
      ..repeat(reverse: true);

    particleController = AnimationController(vsync: vsync, duration: const Duration(seconds: 6))
      ..repeat();

    _startMainAnimation();
    _startTyping();
  }

  Future<void> _startMainAnimation() async {
    await logoController.forward();
    await textController.forward();
    await lineController.forward();
  }

  void _startTyping() async {
    for (int i = 0; i < fullText.length; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      typedText += fullText[i];
      notifyListeners();
    }
  }

  void disposeAll() {
    logoController.dispose();
    textController.dispose();
    lineController.dispose();
    shimmerController.dispose();
    bgPulseController.dispose();
    particleController.dispose();
  }
}
