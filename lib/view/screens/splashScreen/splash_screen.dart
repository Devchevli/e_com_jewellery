import 'package:jewellery/core/theme/app_imports.dart';
import 'package:jewellery/core/utils/custom_assets.dart';
import 'package:jewellery/core/widgets/custom_text.dart';
import 'package:jewellery/view/screens/onboarding_screen/onboarding_screen.dart';
import '../../../provider/splash_screen_provider/splash_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late SplashProvider splashProvider;

  @override
  void initState() {
    super.initState();

    splashProvider = context.read<SplashProvider>();
    splashProvider.init(this);

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        (route) => false,
      );
    });
  }

  @override
  void dispose() {
    splashProvider.disposeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<SplashProvider>();

    return Scaffold(
      body: AnimatedBuilder(
        animation: p.bgPulseController,
        builder: (_, __) {
          return Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.2,
                colors: [
                  CustomColor.appSecondaryColor,
                  CustomColor.appSecondaryColor.withOpacity(
                    0.9 + (p.bgPulseController.value * 0.1),
                  ),
                ],
              ),
            ),
            child: Stack(children: [_buildParticles(p), _buildContent(p)]),
          );
        },
      ),
    );
  }

  Widget _buildContent(SplashProvider p) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: p.logoController,
            child: ScaleTransition(
              scale: Tween(
                begin: 0.6,
                end: 1.0,
              ).animate(CurvedAnimation(parent: p.logoController, curve: Curves.easeOutBack)),
              child: CustomImage.asset(assetPath: CustomAssets.appLogo, height: 80),
            ),
          ),
          const SizedBox(height: 20),

          AnimatedBuilder(
            animation: p.shimmerController,
            builder: (_, __) {
              return ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment(-1 + p.shimmerController.value * 2, 0),
                    end: Alignment(1 + p.shimmerController.value * 2, 0),
                    colors: const [
                      Color(0xffB8860B),
                      Color(0xffFFF7AD),
                      Color(0xffF4C025),
                      Color(0xffFFF7AD),
                      Color(0xffB8860B),
                    ],
                  ).createShader(rect);
                },
                child: CustomText(
                  "AURELIA",
                  fontWeight: FontWeight.w200,
                  fontSize: 20.sp,
                  letterSpacing: 10,
                  color: Colors.white,
                ),
              );
            },
          ),

          const SizedBox(height: 25),

          CustomText(
            'FINE JEWELLERY & ART',
            letterSpacing: 6,
            color: CustomColor.yellowPrimary.withOpacity(0.4),
            fontSize: 14,
          ),

          const SizedBox(height: 35),

          AnimatedBuilder(
            animation: p.lineController,
            builder: (_, __) => Container(
              height: 1,
              width: 250 * p.lineController.value,
              color: CustomColor.yellowLight,
            ),
          ),

          const SizedBox(height: 35),

          CustomText(
            p.typedText,
            letterSpacing: 4,
            color: CustomColor.yellowPrimary.withOpacity(0.4),
            fontSize: 10,
          ),

          const SizedBox(height: 35),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: 1, width: 50, color: CustomColor.yellowLight.withOpacity(0.2)),
              const SizedBox(width: 20),
              CustomText(
                'EST. 2026',
                fontSize: 8,
                color: CustomColor.whitePrimary.withOpacity(0.2),
              ),
              const SizedBox(width: 20),
              Container(height: 1, width: 50, color: CustomColor.yellowLight.withOpacity(0.2)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildParticles(SplashProvider p) {
    return AnimatedBuilder(
      animation: p.particleController,
      builder: (_, __) {
        return CustomPaint(
          size: MediaQuery.of(context).size,
          painter: _ParticlePainter(p.particleController.value),
        );
      },
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final double progress;
  _ParticlePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xffF4C025).withOpacity(0.08);

    for (int i = 0; i < 25; i++) {
      final dx = (size.width / 25) * i;
      final dy = (size.height * (progress + i * 0.04)) % size.height;
      canvas.drawCircle(Offset(dx, dy), 1.2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
