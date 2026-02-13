import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jewellery/core/theme/app_imports.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'section_title.dart';

class TrendingSection extends StatefulWidget {
  const TrendingSection({super.key});

  @override
  State<TrendingSection> createState() => _TrendingSectionState();
}

class _TrendingSectionState extends State<TrendingSection> {
  final PageController _pageController = PageController(viewportFraction: 0.78);
  bool _isVisible = false;

  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = List.generate(5, (index) => index);

    return SliverToBoxAdapter(
      child: VisibilityDetector(
        key: const Key("trending-section"),
        onVisibilityChanged: (info) {
          if (info.visibleFraction > 0.3 && !_isVisible) {
            setState(() {
              _isVisible = true;
            });
          }
        },

        child: AnimatedSlide(
          offset: _isVisible ? Offset.zero : const Offset(-0.3, 0),
          duration: const Duration(seconds: 2),
          curve: Curves.easeOutCubic,

          child: AnimatedOpacity(
            opacity: _isVisible ? 1 : 0,
            duration: const Duration(seconds: 2),

            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(
                    title: "Trending Now",
                    subtitle: "Bold pieces defining presence.",
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    height: 460,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: products.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final difference = (currentPage - index);
                        final scale = (1 - (difference.abs() * 0.15)).clamp(0.8, 1.0);
                        final opacity = (1 - (difference.abs() * 0.3)).clamp(0.4, 1.0);

                        return Transform.scale(
                          scale: scale,
                          child: Opacity(
                            opacity: opacity,
                            child: _AnimatedTrendingCard(
                              isFocused: difference.abs() < 0.5,
                              pageOffset: difference,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedTrendingCard extends StatefulWidget {
  final bool isFocused;
  final double pageOffset;

  const _AnimatedTrendingCard({required this.isFocused, required this.pageOffset});

  @override
  State<_AnimatedTrendingCard> createState() => _AnimatedTrendingCardState();
}

class _AnimatedTrendingCardState extends State<_AnimatedTrendingCard> {
  double tiltX = 0;
  double tiltY = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          tiltX = (details.localPosition.dx - 150) / 300;
          tiltY = (details.localPosition.dy - 200) / 400;
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
        margin: const EdgeInsets.symmetric(horizontal: 10),
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(tiltY * 0.06)
          ..rotateY(-tiltX * 0.06),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: widget.isFocused
                  ? CustomColor.yellowPrimary.withOpacity(0.4)
                  : Colors.black.withOpacity(0.5),
              blurRadius: widget.isFocused ? 60 : 30,
              offset: const Offset(0, 30),
            ),
          ],
          border: Border.all(
            color: widget.isFocused
                ? CustomColor.yellowPrimary
                : CustomColor.yellowPrimary.withOpacity(0.2),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              Positioned.fill(
                child: Transform.translate(
                  offset: Offset(widget.pageOffset * 60, 0),
                  child: Image.asset(CustomAssets.onboardingTwo, fit: BoxFit.cover),
                ),
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
                bottom: 30,
                left: 24,
                right: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Luxury Ring",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "₹ 6,999",
                      style: TextStyle(
                        fontSize: 18,
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
