import 'package:flutter/material.dart';
import 'package:jewellery/core/theme/app_imports.dart';
import 'package:jewellery/view/screens/product_detail_screen/widgets/floating_glass_actionbar.dart';
import 'package:jewellery/view/screens/product_detail_screen/widgets/product_carft_section.dart';
import 'package:jewellery/view/screens/product_detail_screen/widgets/product_identity_section.dart';
import 'package:jewellery/view/screens/product_detail_screen/widgets/product_image_gallery.dart';
import 'package:jewellery/view/screens/product_detail_screen/widgets/product_story_section.dart';

class ProductDetailsScreen extends StatefulWidget {
  final List<String> images;

  const ProductDetailsScreen({super.key, required this.images});

  @override
  State<ProductDetailsScreen> createState() => ProductDetailsScreenState();
}

class ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final PageController pageController = PageController(viewportFraction: 1);

  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.appSecondaryColor,
      body: Stack(
        children: [
          /// Scrollable Content
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ProductImageGallery(images: widget.images, pageController: pageController),
              ),

              SliverToBoxAdapter(child: ProductIdentitySection()),

              SliverToBoxAdapter(child: ProductCraftSection()),

              SliverToBoxAdapter(child: ProductStorySection()),

              const SliverToBoxAdapter(child: SizedBox(height: 140)),
            ],
          ),

          /// Floating Glass Action Bar
          const FloatingGlassActionBar(),
        ],
      ),
    );
  }
}
