import 'package:flutter/material.dart';
import 'package:jewellery/core/theme/app_imports.dart';
import 'package:jewellery/view/screens/home_screen/widgets/category_section.dart';
import 'package:jewellery/view/screens/home_screen/widgets/featured_grid_section.dart';
import 'package:jewellery/view/screens/home_screen/widgets/hero_section.dart';
import 'package:jewellery/view/screens/home_screen/widgets/limited_drop_section.dart';
import 'package:jewellery/view/screens/home_screen/widgets/section_title.dart';
import 'package:jewellery/view/screens/home_screen/widgets/story_section.dart';
import 'package:jewellery/view/screens/home_screen/widgets/trending_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.appSecondaryColor,
      body: Stack(
        children: [
          Container(color: CustomColor.appSecondaryColor),
          Positioned(
            top: -250,
            left: -120,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColor.yellowPrimary.withOpacity(0.04),
              ),
            ),
          ),
          Positioned(
            bottom: -300,
            right: -150,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColor.yellowDark.withOpacity(0.03),
              ),
            ),
          ),

          CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(child: HeroSection()),

              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    StorySection(
                      headline: "Jewellery is Identity",
                      paragraph:
                          "Every piece is crafted with intention, emotion, and timeless precision.",
                    ),
                  ],
                ),
              ),

              const CategorySection(),

              const TrendingSection(),

              const FeaturedGridSection(),

              const LimitedDropSection(),
            ],
          ),
        ],
      ),
    );
  }
}
