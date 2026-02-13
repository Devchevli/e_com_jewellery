import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jewellery/core/theme/app_imports.dart';

class CampaignCarousel extends StatefulWidget {
  final List<Map<String, String>> banners;

  const CampaignCarousel({super.key, required this.banners});

  @override
  State<CampaignCarousel> createState() => _CampaignCarouselState();
}

class _CampaignCarouselState extends State<CampaignCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.92);

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
    if (widget.banners.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox());
    }

    if (widget.banners.length == 1) {
      return SliverToBoxAdapter(child: _CampaignCard(data: widget.banners.first));
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: SizedBox(
          height: 420,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.banners.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final difference = (currentPage - index);
              final scale = (1 - (difference.abs() * 0.08)).clamp(0.9, 1.0);

              return Transform.scale(
                scale: scale,
                child: _CampaignCard(data: widget.banners[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CampaignCard extends StatelessWidget {
  final Map<String, String> data;

  const _CampaignCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            /// Image
            Positioned.fill(
              child: Image.asset(data["image"] ?? "", fit: BoxFit.cover)
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.04, 1.04),
                    duration: 10.seconds,
                  ),
            ),

            /// Gradient
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [CustomColor.appSecondaryColor.withOpacity(0.9), Colors.transparent],
                  ),
                ),
              ),
            ),

            /// Text
            Positioned(
              bottom: 40,
              left: 30,
              right: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data["title"] ?? "",
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2),

                  const SizedBox(height: 8),

                  Text(
                    data["subtitle"] ?? "",
                    style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.75)),
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
