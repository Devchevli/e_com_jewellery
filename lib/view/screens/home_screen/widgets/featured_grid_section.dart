import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jewellery/core/theme/app_imports.dart';
import 'section_title.dart';

class FeaturedGridSection extends StatefulWidget {
  const FeaturedGridSection({super.key});

  @override
  State<FeaturedGridSection> createState() => _FeaturedGridSectionState();
}

class _FeaturedGridSectionState extends State<FeaturedGridSection> {
  final ScrollController _scrollController = ScrollController();
  double scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = List.generate(8, (index) => index);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: "Featured Picks",
              subtitle: "Curated with timeless precision.",
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 40,
                ),
                itemBuilder: (context, index) {
                  return _FeaturedCard(index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedCard extends StatefulWidget {
  final int index;

  const _FeaturedCard({required this.index});

  @override
  State<_FeaturedCard> createState() => _FeaturedCardState();
}

class _FeaturedCardState extends State<_FeaturedCard> {
  double tiltX = 0;
  double tiltY = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          tiltX = (details.localPosition.dx - 100) / 200;
          tiltY = (details.localPosition.dy - 150) / 300;
        });
      },
      onPanEnd: (_) {
        setState(() {
          tiltX = 0;
          tiltY = 0;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(tiltY * 0.05)
          ..rotateY(-tiltX * 0.05),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 35,
              offset: const Offset(0, 25),
            ),
          ],
          border: Border.all(color: CustomColor.yellowPrimary.withOpacity(0.15)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              /// Parallax image
              Positioned.fill(
                child: Transform.translate(
                  offset: Offset(tiltX * 20, tiltY * 20),
                  child: Image.asset(CustomAssets.onboardingOne, fit: BoxFit.cover),
                ),
              ),

              /// Dark gradient
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
                bottom: 20,
                left: 18,
                right: 18,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Signature Piece",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "₹ 8,499",
                      style: TextStyle(
                        color: CustomColor.yellowPrimary,
                        fontWeight: FontWeight.w600,
                      ),
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
