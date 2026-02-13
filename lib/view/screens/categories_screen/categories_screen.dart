import 'package:flutter_animate/flutter_animate.dart';
import 'package:jewellery/core/theme/app_imports.dart';
import 'package:jewellery/core/widgets/custom_scroll.dart';
import 'package:jewellery/view/screens/categories_screen/widgets/featured_categories.dart';
import 'package:jewellery/view/screens/categories_screen/widgets/mini_categories_card.dart';
import 'package:jewellery/view/screens/categories_screen/widgets/sub_categories_row.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.appSecondaryColor,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          /// HEADER
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            pinned: true,
            centerTitle: true,
            title: const Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),

          /// FEATURED HERO CATEGORY
          SliverToBoxAdapter(
            child: ScrollReveal(beginOffset: const Offset(0, 0.15), child: FeaturedCategoryHero()),
          ),

          /// SUBCATEGORIES
          SliverToBoxAdapter(child: SubCategoryRow()),

          /// FEATURED COLLECTION
          SliverToBoxAdapter(
            child: ScrollReveal(
              beginOffset: const Offset(-0.3, 0),
              child: CategoryFeaturedCarousel(),
            ),
          ),

          /// EDITORIAL QUOTE
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Center(
                child: Text(
                  "Jewellery is not worn. It is carried.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.7),
                    letterSpacing: 1.2,
                  ),
                ).animate().fadeIn(duration: 1000.ms).slideY(begin: 0.2),
              ),
            ),
          ),

          /// CATEGORY GRID
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => MiniCategoryCard(),
                childCount: 6,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 30,
                childAspectRatio: 0.8,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }
}
