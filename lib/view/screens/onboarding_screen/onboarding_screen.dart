import 'package:jewellery/core/theme/app_imports.dart';
import 'package:jewellery/view/screens/loginScreen/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnboardingModel> pages = [
    OnboardingModel(
      image: CustomAssets.onboardingOne,
      title: "Moments in Gold",
      subtitle: "Every sparkle tells a story.",
    ),
    OnboardingModel(
      image: CustomAssets.onboardingTen,
      title: "A Touch of Forever",
      subtitle: "Jewellery that lives beyond time.",
    ),
    OnboardingModel(
      image: CustomAssets.onboardingNine,
      title: "Grace in Every Detail",
      subtitle: "Because elegance is eternal.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OnboardingProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// PAGE VIEW
          PageView.builder(
            controller: provider.pageController,
            itemCount: pages.length,
            onPageChanged: provider.setPage,
            itemBuilder: (context, index) {
              return OnboardingPage(model: pages[index]);
            },
          ),

          /// STORY STYLE INDICATOR (TOP)
          Positioned(
            top: 55,
            left: 20,
            right: 20,
            child: SmoothPageIndicator(
              controller: provider.pageController,
              count: pages.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 4,
                dotWidth: 20,
                activeDotColor: Color(0xFFD4AF37),
                dotColor: Colors.white24,
              ),
            ),
          ),

          Positioned(
            top: 55,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: const CustomText("Skip", color: Colors.white70, letterSpacing: 1.2),
            ),
          ),
        ],
      ),
    );
  }
}
