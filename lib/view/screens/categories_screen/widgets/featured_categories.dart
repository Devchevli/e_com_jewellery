import 'package:flutter_animate/flutter_animate.dart';
import 'package:jewellery/core/theme/app_imports.dart';

class FeaturedCategoryHero extends StatelessWidget {
  const FeaturedCategoryHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            Image.asset(
                  CustomAssets.onboardingTwo,
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.05, 1.05),
                  duration: 10.seconds,
                ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [CustomColor.appSecondaryColor.withOpacity(0.95), Colors.transparent],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 40,
              left: 30,
              child: Text(
                "Rings Collection",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.yellowPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryFeaturedCarousel extends StatefulWidget {
  const CategoryFeaturedCarousel({super.key});

  @override
  State<CategoryFeaturedCarousel> createState() => CategoryFeaturedCarouselState();
}

class CategoryFeaturedCarouselState extends State<CategoryFeaturedCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.85);

  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        currentPage = _controller.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = List.generate(5, (index) => index);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: SizedBox(
        height: 280,
        child: PageView.builder(
          controller: _controller,
          physics: const BouncingScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final difference = currentPage - index;
            final scale = (1 - (difference.abs() * 0.08)).clamp(0.9, 1.0);

            return Transform.scale(
              scale: scale,
              child: FeaturedCategoryCard(pageOffset: difference),
            );
          },
        ),
      ),
    );
  }
}

class FeaturedCategoryCard extends StatelessWidget {
  final double pageOffset;

  const FeaturedCategoryCard({required this.pageOffset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            /// Parallax Image
            Positioned.fill(
              child: Transform.translate(
                offset: Offset(pageOffset * 30, 0),
                child: Image.asset(CustomAssets.onboardingOne, fit: BoxFit.cover),
              ),
            ),

            /// Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [CustomColor.appSecondaryColor.withOpacity(0.95), Colors.transparent],
                  ),
                ),
              ),
            ),

            /// Content
            Positioned(
              bottom: 25,
              left: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Signature Rings",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.yellowPrimary,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Curated pieces of rare elegance",
                    style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
