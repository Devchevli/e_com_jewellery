import 'dart:ui';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:jewellery/core/theme/app_imports.dart';

class OnboardingPage extends StatefulWidget {
  final OnboardingModel model;

  const OnboardingPage({super.key, required this.model});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with SingleTickerProviderStateMixin {
  double xTilt = 0;
  double yTilt = 0;
  late AnimationController _zoomController;
  StreamSubscription? _accelSubscription;

  @override
  @override
  void initState() {
    super.initState();

    _zoomController = AnimationController(vsync: this, duration: const Duration(seconds: 12))
      ..repeat(reverse: true);

    _accelSubscription = accelerometerEvents.listen((event) {
      if (!mounted) return;

      if (event.x.abs() < 0.2 && event.y.abs() < 0.2) return;

      setState(() {
        xTilt = event.y * 0.008;
        yTilt = event.x * 0.008;
      });
    });
  }

  @override
  void dispose() {
    _zoomController.dispose();
    _accelSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OnboardingProvider>(context, listen: false);

    return GestureDetector(
      onPanUpdate: (details) {
        if (!mounted) ;
        return setState(() {
          xTilt += details.delta.dy * 0.0005;
          yTilt -= details.delta.dx * 0.0005;
        });
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// BACKGROUND
          AnimatedBuilder(
            animation: _zoomController,
            builder: (context, child) {
              double zoom = 1.0 + (_zoomController.value * 0.09);

              return Transform.scale(
                scale: zoom,
                child: Image.asset(widget.model.image ?? '', fit: BoxFit.cover),
              );
            },
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(color: Colors.black.withOpacity(0.1)),
          ),

          /// DARK GRADIENT
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black54, Colors.black87],
              ),
            ),
          ),

          /// 3D TILT JEWELLERY LAYER
          Center(
            child: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(xTilt)
                ..rotateY(yTilt),
              child: Image.asset(widget.model.image ?? '', height: 300)
                  .animate(onPlay: (c) => c.repeat())
                  .shimmer(duration: 4.seconds, color: const Color(0x55D4AF37)),
            ),
          ),

          /// NATURAL MOVING SPOTLIGHT
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _zoomController,
                builder: (context, child) {
                  double lightX = sin(_zoomController.value * pi * 2) * 120;
                  double lightY = cos(_zoomController.value * pi * 2) * 60;

                  return Transform.translate(
                    offset: Offset(lightX, lightY),
                    child: Opacity(
                      opacity: 0.18,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            radius: 0.45,
                            colors: [Color(0xAAFFD700), Colors.transparent],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          /// FLOATING GOLD PARTICLES
          Positioned.fill(
            child: IgnorePointer(
              child: Stack(
                children: List.generate(12, (index) {
                  return Positioned(
                    left: (index * 30.0) % MediaQuery.of(context).size.width,
                    top: (index * 50.0) % MediaQuery.of(context).size.height,
                    child:
                        Container(
                              width: 3,
                              height: 3,
                              decoration: const BoxDecoration(
                                color: CustomColor.yellowLight,
                                shape: BoxShape.circle,
                              ),
                            )
                            .animate(onPlay: (c) => c.repeat())
                            .moveY(begin: 0, end: -40, duration: 6.seconds)
                            .fadeIn(duration: 2.seconds)
                            .fadeOut(),
                  );
                }),
              ),
            ),
          ),

          /// CONTENT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),

                CustomText(
                  maxLines: 2,
                  widget.model.title,
                  fontSize: 44,
                  fontWeight: FontWeight.w500,
                  font: GoogleFonts.greatVibes,
                  lineHeight: 1.1,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFE082), Color(0xFFD4AF37), Color(0xFFB8860B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ).animate().fadeIn(duration: 900.ms).slideY(begin: 0.3),

                const SizedBox(height: 15),

                CustomText(
                  widget.model.subtitle,
                  color: Colors.white70,
                  fontSize: 16,
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),

                const SizedBox(height: 50),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      if (provider.currentPage < 2) {
                        provider.pageController.nextPage(duration: 700.ms, curve: Curves.easeInOut);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFD4AF37), Color(0xFFB8860B)],
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText("Next", color: Colors.black),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward, color: Colors.black, size: 18),
                        ],
                      ),
                    ),
                  ),
                ).animate().scale(delay: 500.ms),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
